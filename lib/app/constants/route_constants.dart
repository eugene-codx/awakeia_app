/// Route constants for navigation
/// Centralized place for all route paths
class RouteConstants {
  RouteConstants._();

  // Main routes
  static const String loading = '/';
  static const String first = '/first';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  // Feature routes
  static const String profile = '/profile';
  static const String habits = '/habits';
  static const String statistics = '/statistics';
  static const String settings = '/settings';

  // Habit routes (for future)
  static const String createHabit = '/habits/create';
  static const String editHabit = '/habits/edit';
  static const String habitDetails = '/habits/details';

  // Auth routes (for future)
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';

  // Error routes
  static const String error = '/error';
  static const String notFound = '/404';
}

/// Route names for named navigation
class RouteNames {
  RouteNames._();

  static const String loading = 'loading';
  static const String first = 'first';
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String profile = 'profile';
  static const String habits = 'habits';
  static const String statistics = 'statistics';
  static const String settings = 'settings';
  static const String createHabit = 'create-habit';
  static const String editHabit = 'edit-habit';
  static const String habitDetails = 'habit-details';
  static const String forgotPassword = 'forgot-password';
  static const String resetPassword = 'reset-password';
  static const String verifyEmail = 'verify-email';
  static const String error = 'error';
  static const String notFound = 'not-found';
}
