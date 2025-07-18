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
        onError: (error, handler) {
          _handleError(error, handler);
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
            await SecureStorage.instance.read(key: StorageKeys.authToken);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }

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
  void _handleError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    AppLogger.error('Network error: ${error.message}');

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        AppLogger.error('Request timeout: ${error.message}');
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        AppLogger.error('Bad response: $statusCode');

        // Handle specific status codes
        switch (statusCode) {
          case 401:
            _handleUnauthorized();
            break;
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
        break;
    }

    handler.next(error);
  }

  /// Handle unauthorized responses
  void _handleUnauthorized() {
    AppLogger.warning('Unauthorized access - token may be expired');
    // Clear stored token
    SecureStorage.instance.delete(key: StorageKeys.authToken);
    // Note: In a real app, you might want to navigate to login screen
    // This would typically be handled by a navigation service
  }

  /// Clear all stored authentication data
  Future<void> clearAuthData() async {
    await SecureStorage.instance.delete(key: StorageKeys.authToken);
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
