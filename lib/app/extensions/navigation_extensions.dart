import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/route_constants.dart';

/// Extensions for easier navigation with go_router
extension NavigationExtensions on BuildContext {
  /// Navigate to login with optional redirect
  void goToLogin({String? redirect}) {
    if (redirect != null && redirect.isNotEmpty) {
      go('/login?redirect=$redirect');
    } else {
      go(RouteConstants.login);
    }
  }

  /// Navigate to register with optional redirect
  void goToRegister({String? redirect}) {
    if (redirect != null && redirect.isNotEmpty) {
      go('/register?redirect=$redirect');
    } else {
      go('/register');
    }
  }

  /// Show coming soon message
  void showComingSoon(String feature) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Show error message
  void showError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show success message
  void showSuccess(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Navigate to home
  void goToHome() => go('/home');

  /// Navigate to first/welcome screen
  void goToFirst() => go('/first');

  /// Navigate to profile
  void goToProfile() => go('/profile');

  /// Navigate to habits
  void goToHabits() => go('/habits');

  /// Navigate to statistics
  void goToStatistics() => go('/statistics');

  /// Navigate back or to fallback route
  void goBackOrTo(String fallbackRoute) {
    if (canPop()) {
      pop();
    } else {
      go(fallbackRoute);
    }
  }

  /// Check if current route matches path
  bool isCurrentRoute(String path) {
    final currentLocation = GoRouterState.of(this).matchedLocation;
    return currentLocation == path;
  }

  /// Get current route path
  String get currentRoute => GoRouterState.of(this).matchedLocation;

  /// Get query parameters
  Map<String, String> get queryParams =>
      GoRouterState.of(this).uri.queryParameters;

  /// Get specific query parameter
  String? queryParam(String key) => queryParams[key];
}
