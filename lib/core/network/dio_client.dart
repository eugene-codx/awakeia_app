import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../logging/app_logger.dart';
import '../storage/secure_storage.dart';
import '../storage/storage_keys.dart';
import 'api_endpoints.dart';

/// Dio HTTP client configuration and setup
/// Provides a centralized way to configure network requests
class DioClient {
  /// Private constructor
  DioClient._internal() {
    _dio = Dio();
    _configureDio();
    _setupInterceptors();
  }
  static DioClient? _instance;
  late final Dio _dio;

  /// Singleton instance
  static DioClient get instance => _instance ??= DioClient._internal();

  /// Get the configured Dio instance
  Dio get dio => _dio;

  // common future, to handle refreshing token and retrying request
  Future<bool>? _refreshing;

  /// Configure base Dio options
  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status != null && status >= 200 && status < 300;
      },
    );
  }

  /// Setup interceptors for logging, authentication, and error handling
  void _setupInterceptors() {
    // Add pretty logger only in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    // Add authentication interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await _handleAuthRequest(options, handler);
        },
        onResponse: (response, handler) {
          _handleResponse(response, handler);
        },
        onError: (error, handler) async {
          await _handleErrorAsync(error, handler);
        },
      ),
    );
  }

  /// Handle authentication for outgoing requests
  Future<void> _handleAuthRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Check if endpoint requires authentication
      final requiresAuth = options.extra['requiresAuth'] as bool? ?? false;

      if (requiresAuth) {
        final token =
            await SecureStorage.instance.read(key: StorageKeys.accessToken);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }

      // save the original flag onError
      options.extra['__originalRequiresAuth'] = requiresAuth;
      // Remove the extra flag to avoid sending it to server
      options.extra.remove('requiresAuth');

      handler.next(options);
    } catch (e) {
      AppLogger.error('Error adding auth header: $e');
      handler.next(options);
    }
  }

  /// Handle successful responses
  void _handleResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.info('Response received: ${response.statusCode}');
    handler.next(response);
  }

  /// Handle errors and transform them appropriately
  Future<void> _handleErrorAsync(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    AppLogger.error('Network error: ${error.message}');

    final statusCode = error.response?.statusCode;
    final isRefreshCall = error.requestOptions.extra['isRefreshCall'] == true;
    final alreadyRetried = error.requestOptions.extra['__retried'] == true;
    final originallyRequiredAuth =
        (error.requestOptions.extra['__originalRequiresAuth'] as bool?) ??
            false;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        AppLogger.error('Request timeout: ${error.message}');
        break;
      case DioExceptionType.badResponse:
        AppLogger.error('Bad response: $statusCode');

        if (statusCode == 401 &&
            !isRefreshCall &&
            originallyRequiredAuth &&
            !alreadyRetried) {
          final refreshed = await _ensureRefreshedToken();
          if (refreshed) {
            try {
              final retryResponse = await _retry(error.requestOptions);
              handler.resolve(retryResponse);
              return;
            } catch (e) {
              AppLogger.error('Retry after refresh failed: $e');
            }
          }

          // refresh не удался — чистим токены и дергаем колбэк
          await _handleUnauthorized();
        } else {
          // Handle specific status codes
          switch (statusCode) {
            case 403:
              AppLogger.error('Access forbidden');
              break;
            case 404:
              AppLogger.error('Resource not found');
              break;
            case 500:
              AppLogger.error('Internal server error');
              break;
          }
        }
        break;
      case DioExceptionType.cancel:
        AppLogger.info('Request cancelled');
        break;
      case DioExceptionType.connectionError:
        AppLogger.error('Connection error: ${error.message}');
        break;
      case DioExceptionType.badCertificate:
        AppLogger.error('Bad certificate: ${error.message}');
        break;
      case DioExceptionType.unknown:
        AppLogger.error('Unknown error: ${error.message}');
        AppLogger.error('Error details: ${error.error}');
        AppLogger.error('Request URL: ${error.requestOptions.uri}');
        if (error.error != null) {
          AppLogger.error('Underlying error type: ${error.error.runtimeType}');
        }
        break;
    }

    handler.next(error); // по умолчанию пробрасываем ошибку дальше
  }

  // NEW: единая точка для refresh с дедупликацией параллельных попыток
  Future<bool> _ensureRefreshedToken() async {
    // Уже выполняется? — просто ждём тот же Future
    if (_refreshing != null) {
      AppLogger.info('Refresh already in progress — awaiting…');
      return await _refreshing!;
    }

    final completer = Completer<bool>();
    _refreshing = completer.future;

    try {
      final refreshToken =
          await SecureStorage.instance.read(key: StorageKeys.refreshToken);

      if (refreshToken == null || refreshToken.isEmpty) {
        AppLogger.warning('No refresh token available');
        completer.complete(false);
        return false;
      }

      // Сам refresh-запрос — явно выключаем requiresAuth, и помечаем как isRefreshCall
      final resp = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        data: {
          'token': refreshToken,
        },
        options: Options(
          extra: {
            'requiresAuth': false,
            'isRefreshCall': true,
            // сохранять флаг не нужно
          },
          headers: {
            // Убедимся, что Authorization не уедет старый
            'Authorization': null,
          },
        ),
      );

      final ok = resp.statusCode == 200 && resp.data != null;
      if (!ok) {
        AppLogger.warning('Refresh failed with status: ${resp.statusCode}');
        completer.complete(false);
        return false;
      }

      final map = resp.data!;
      // Ожидаем те же ключи, что ты уже используешь в login/register
      final newAccess = map[StorageKeys.accessToken] as String?;
      final newRefresh =
          (map[StorageKeys.refreshToken] as String?) ?? refreshToken;

      if (newAccess == null || newAccess.isEmpty) {
        AppLogger.warning('Refresh response has no access token');
        completer.complete(false);
        return false;
      }

      await SecureStorage.instance
          .write(key: StorageKeys.accessToken, value: newAccess);
      await SecureStorage.instance
          .write(key: StorageKeys.refreshToken, value: newRefresh);

      AppLogger.info('Token refreshed successfully');
      completer.complete(true);
      return true;
    } catch (e, st) {
      AppLogger.error('Refresh error', e, st);
      completer.complete(false);
      return false;
    } finally {
      _refreshing =
          null; // сбрасываем, чтобы следующие 401 могли инициировать новый refresh
    }
  }

  // NEW: повтор исходного запроса после успешного refresh
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // пометим, что это ретрай, чтобы не зациклиться
    final newExtra = Map<String, dynamic>.from(requestOptions.extra)
      ..['__retried'] = true;

    // ПРИМЕЧАНИЕ: изначальный флаг requiresAuth убирали в onRequest,
    // но нам важно знать, был ли он — сохраним его заранее (см. ниже).
    // Здесь просто повторяем запрос с актуальным заголовком Authorization
    final access =
        await SecureStorage.instance.read(key: StorageKeys.accessToken);

    final opts = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        if (access != null) 'Authorization': 'Bearer $access',
      },
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      followRedirects: requestOptions.followRedirects,
      listFormat: requestOptions.listFormat,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      extra: newExtra,
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: opts,
      cancelToken: requestOptions.cancelToken,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
    );
  }

  /// Handle unauthorized responses
  Future<void> _handleUnauthorized() async {
    AppLogger.warning('Unauthorized access - token may be expired');
    // Clear stored token
    await clearAuthData();
  }

  /// Clear all stored authentication data
  Future<void> clearAuthData() async {
    await SecureStorage.instance.delete(key: StorageKeys.accessToken);
    await SecureStorage.instance.delete(key: StorageKeys.refreshToken);
  }

  /// Update base URL (useful for environment switching)
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }

  /// Add or update global headers
  void updateHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  /// Cancel all pending requests
  void cancelAllRequests() {
    _dio.close(force: true);
  }
}
