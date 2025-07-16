/// API endpoints configuration
/// Centralized place for all API endpoint definitions
class ApiEndpoints {
  // Private constructor to prevent instantiation
  ApiEndpoints._();

  /// Base URL for the API
  static const String baseUrl = 'https://codxcelerate.com/api';

  /// API version
  static const String version = '/v1';

  /// Authentication endpoints
  static const String login = '$version/auth/login';
  static const String register = '$version/auth/register';
  static const String logout = '$version/auth/logout';
  static const String refreshToken = '$version/auth/refresh';
  static const String forgotPassword = '$version/auth/forgot-password';
  static const String resetPassword = '$version/auth/reset-password';
  static const String verifyEmail = '$version/auth/verify-email';

  /// User endpoints
  static const String userProfile = '$version/user/profile';
  static const String updateProfile = '$version/user/profile';
  static const String changePassword = '$version/user/change-password';
  static const String deleteAccount = '$version/user/delete';

  /// Habits endpoints (for future implementation)
  static const String habits = '$version/habits';
  static const String createHabit = '$version/habits';
  static const String updateHabit = '$version/habits';
  static const String deleteHabit = '$version/habits';
  static const String habitStats = '$version/habits/stats';

  /// Utility methods for dynamic endpoints

  /// Get habit by ID
  static String habitById(String id) => '$version/habits/$id';

  /// Get habit stats by ID
  static String habitStatsById(String id) => '$version/habits/$id/stats';

  /// Get habits by user ID
  static String habitsByUserId(String userId) =>
      '$version/users/$userId/habits';

  /// Get user by ID
  static String userById(String id) => '$version/users/$id';

  /// Build query parameters string
  static String withQueryParams(String endpoint, Map<String, dynamic> params) {
    if (params.isEmpty) return endpoint;

    final queryString = params.entries
        .where((entry) => entry.value != null)
        .map((entry) =>
            '${entry.key}=${Uri.encodeComponent(entry.value.toString())}',)
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
