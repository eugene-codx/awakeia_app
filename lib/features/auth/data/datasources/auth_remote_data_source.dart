import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/storage/storage_keys.dart';
import '../models/user_model.dart';

/// Abstract class defining the contract for remote authentication operations
abstract class AuthRemoteDataSource {
  /// Sign in with email and password
  /// Throws [ServerException] on failure
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Register new user with email and password
  /// Throws [ServerException] on failure
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String firstName,
  });

  /// Sign out current user
  /// Throws [ServerException] on failure
  Future<void> signOut();

  /// Get current user from server
  /// Returns null if not authenticated
  /// Throws [ServerException] on failure
  Future<UserModel?> getCurrentUser();

  /// Update user profile
  /// Throws [ServerException] on failure
  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  });
}

/// Implementation of AuthRemoteDataSource
/// Uses real HTTP requests via DioClient
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl() : _dio = DioClient.instance.dio;

  final Dio _dio;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {
          'email_username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data as Map<String, dynamic>;

        // Extract and save token if present
        if (responseData.containsKey(StorageKeys.accessToken)) {
          final token = responseData[StorageKeys.accessToken] as String;
          await SecureStorage.instance.write(
            key: StorageKeys.accessToken,
            value: token,
          );

          // Save additional auth info if present
          if (responseData.containsKey(StorageKeys.refreshToken)) {
            await SecureStorage.instance.write(
              key: StorageKeys.refreshToken,
              value: responseData[StorageKeys.refreshToken] as String,
            );
          }
        }
      } else {
        throw const ServerException('Invalid response from server');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorData = e.response!.data;

        switch (statusCode) {
          case 401:
            throw const ServerException('Invalid email or password');
          case 422:
            final message =
                errorData?['message'] as String? ?? 'Invalid input data';
            throw ServerException(message);
          case 500:
            throw const ServerException('Server error occurred');
          default:
            throw ServerException(
              'Login failed: ${e.response!.statusMessage ?? 'Unknown error'}',
            );
        }
      } else {
        // Network error
        throw const ServerException(
          'Network error. Please check your internet connection',
        );
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String firstName,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: {
          'username': username,
          'password': password,
          'confirm_password': password,
          'email': email,
          'first_name': firstName,
        },
      );
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data as Map<String, dynamic>;

        // Extract and save token if present
        if (responseData.containsKey('message') &&
            responseData['message'] == 'You have successfully registered!') {
          // Registration successful but no user data returned
          // User needs to log in separately
        }
      } else {
        throw const ServerException('Invalid response from server');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorData = e.response!.data;

        switch (statusCode) {
          case 409:
            final message =
                errorData?['detail'] as String? ?? 'User already exists';
            throw ServerException(message);
          case 422:
            throw const ServerException('Invalid input data');
          case 500:
            throw const ServerException('Server error occurred');
          default:
            throw ServerException(
              'Registration failed: ${e.response!.statusMessage ?? 'Unknown error'}',
            );
        }
      } else {
        // Network error
        throw const ServerException(
          'Network error. Please check your internet connection',
        );
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.logout,
        options: Options(
          extra: {'requiresAuth': true}, // Requires authentication token
        ),
      );

      // Clear auth data from client after successful logout
      await DioClient.instance.clearAuthData();
    } on DioException catch (e) {
      // Even if logout fails on server, clear local auth data
      await DioClient.instance.clearAuthData();

      // Don't throw error for logout - log it but continue
      if (e.response?.statusCode != 401) {
        // 401 is expected if token is already expired
        throw ServerException('Logout failed: ${e.message}');
      }
    } catch (e) {
      await DioClient.instance.clearAuthData();
      throw ServerException('Unexpected error during logout: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.me,
        options: Options(
          extra: {'requiresAuth': true}, // Requires authentication token
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        return null; // No user found
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token expired or invalid - clear auth data
        await DioClient.instance.clearAuthData();
        return null; // Not authenticated
      }

      throw ServerException('Failed to get current user: ${e.message}');
    } catch (e) {
      throw ServerException('Unexpected error getting user: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;

      final response = await _dio.put<Map<String, dynamic>>(
        ApiEndpoints.updateProfile,
        data: data,
        options: Options(
          extra: {'requiresAuth': true}, // Requires authentication token
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw const ServerException('Invalid response from server');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;

        switch (statusCode) {
          case 401:
            await DioClient.instance.clearAuthData();
            throw const ServerException('Authentication required');
          case 403:
            throw const ServerException('Access forbidden');
          case 422:
            final errorData = e.response!.data;
            final message =
                errorData?['message'] as String? ?? 'Invalid input data';
            throw ServerException(message);
          case 500:
            throw const ServerException('Server error occurred');
          default:
            throw ServerException(
              'Update failed: ${e.response!.statusMessage ?? 'Unknown error'}',
            );
        }
      } else {
        throw const ServerException(
          'Network error. Please check your internet connection',
        );
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}
