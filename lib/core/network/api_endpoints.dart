import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API endpoints configuration
/// Centralized place for all API endpoint definitions
class ApiEndpoints {
  // Private constructor to prevent instantiation
  ApiEndpoints._();

  /// Base URL for the API
  static final String baseUrl = dotenv.env['API_URL'] ?? '';

  /// API version
  static final String version = dotenv.env['API_VERSION'] ?? '';

  /// Authentication endpoints
  static String get me => '$baseUrl/$version/auth/me';
  static String get login => '$baseUrl/$version/auth/login';
  static String get register => '$baseUrl/$version/auth/register';
  static String get logout => '$baseUrl/$version/auth/logout';
  static String get refreshToken => '$baseUrl/$version/auth/refresh';
  static String get forgotPassword => '$baseUrl/$version/auth/forgot-password';
  static String get resetPassword => '$baseUrl/$version/auth/reset-password';
  static String get verifyEmail => '$baseUrl/$version/auth/verify-email';

  /// User endpoints
  static String get userProfile => '$baseUrl/$version/user/profile';
  static String get updateProfile => '$baseUrl/$version/user/profile';
  static String get changePassword => '$baseUrl/$version/user/change-password';
  static String get deleteAccount => '$baseUrl/$version/user/delete';

  /// Habits endpoints (for future implementation)
  static String get habits => '$baseUrl/$version/habits';
  static String get createHabit => '$baseUrl/$version/habits';
  static String get updateHabit => '$baseUrl/$version/habits';
  static String get deleteHabit => '$baseUrl/$version/habits';
  static String get habitStats => '$baseUrl/$version/habits/stats';

  /// Utility methods for dynamic endpoints

  /// Get habit by ID
  static String habitById(String id) => '$baseUrl$version/habits/$id';

  /// Get habit stats by ID
  static String habitStatsById(String id) =>
      '$baseUrl$version/habits/$id/stats';

  /// Get habits by user ID
  static String habitsByUserId(String userId) =>
      '$baseUrl$version/users/$userId/habits';

  /// Get user by ID
  static String userById(String id) => '$baseUrl$version/users/$id';

  /// Build query parameters string
  static String withQueryParams(String endpoint, Map<String, dynamic> params) {
    if (params.isEmpty) return endpoint;

    final queryString = params.entries
        .where((entry) => entry.value != null)
        .map(
          (entry) =>
              '${entry.key}=${Uri.encodeComponent(entry.value.toString())}',
        )
        .join('&');

    return '$endpoint?$queryString';
  }

  /// Build paginated endpoint
  static String withPagination(String endpoint, {int? page, int? limit}) {
    final params = <String, dynamic>{};
    if (page != null) params['page'] = page;
    if (limit != null) params['limit'] = limit;

    return withQueryParams(endpoint, params);
  }
}
