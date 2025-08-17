/// API endpoints configuration
/// Centralized place for all API endpoint definitions
class ApiEndpoints {
  // Private constructor to prevent instantiation
  ApiEndpoints._();

  /// Base URL for the API
  static const String baseUrl = 'https://codxcelerate.com';

  /// API version
  static const String version = '/1b9d6bcd-bbfd-4b2d-9b5d-ab8dfbbd4b1e';

  /// Authentication endpoints
  static const String me = '$baseUrl$version/auth/me';
  static const String login = '$baseUrl$version/auth/login';
  static const String register = '$baseUrl$version/auth/register';
  static const String logout = '$baseUrl$version/auth/logout';
  static const String refreshToken = '$baseUrl$version/auth/refresh';
  static const String forgotPassword = '$baseUrl$version/auth/forgot-password';
  static const String resetPassword = '$baseUrl$version/auth/reset-password';
  static const String verifyEmail = '$baseUrl$version/auth/verify-email';

  /// User endpoints
  static const String userProfile = '$baseUrl$version/user/profile';
  static const String updateProfile = '$baseUrl$version/user/profile';
  static const String changePassword = '$baseUrl$version/user/change-password';
  static const String deleteAccount = '$baseUrl$version/user/delete';

  /// Habits endpoints (for future implementation)
  static const String habits = '$baseUrl$version/habits';
  static const String createHabit = '$baseUrl$version/habits';
  static const String updateHabit = '$baseUrl$version/habits';
  static const String deleteHabit = '$baseUrl$version/habits';
  static const String habitStats = '$baseUrl$version/habits/stats';

  /// Utility methods for dynamic endpoints

  /// Get habit by ID
  static String habitById(String id) => '$baseUrl$version/habits/$id';

  /// Get habit stats by ID
  static String habitStatsById(String id) => '$baseUrl$version/habits/$id/stats';

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
