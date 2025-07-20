import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/logging/app_logger.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';

/// Auth guard for protecting routes that require authentication
/// Redirects to login if user is not authenticated
String? authGuard(BuildContext context, GoRouterState state) {
  final container = ProviderScope.containerOf(context);

  // Get current auth state
  final authState = container.read(authNotifierProvider);

  // Check if still loading
  if (authState.isLoading) {
    AppLogger.debug('Auth guard: Still loading auth state');
    return null; // Will show loading screen
  }

  // Check authentication status
  final isAuthenticated = authState.valueOrNull?.isAuthenticated ?? false;

  if (!isAuthenticated) {
    AppLogger.info('Auth guard: User not authenticated, redirecting to login');
    // Save the location user was trying to access
    final location = state.uri.toString();
    return '/login?redirect=$location';
  }

  AppLogger.debug('Auth guard: User authenticated, allowing access');
  return null;
}

/// Guest guard for routes that should only be accessible to non-authenticated users
/// Redirects to home if user is already authenticated
String? guestGuard(BuildContext context, GoRouterState state) {
  final container = ProviderScope.containerOf(context);

  // Get current auth state
  final authState = container.read(authNotifierProvider);

  // Check if still loading
  if (authState.isLoading) {
    AppLogger.debug('Guest guard: Still loading auth state');
    return null; // Will show loading screen
  }

  // Check authentication status
  final isAuthenticated = authState.valueOrNull?.isAuthenticated ?? false;

  if (isAuthenticated) {
    AppLogger.info(
      'Guest guard: User already authenticated, redirecting to home',
    );
    return '/home';
  }

  AppLogger.debug('Guest guard: User not authenticated, allowing access');
  return null;
}

/// Optional auth guard - allows both authenticated and non-authenticated users
/// But may change behavior based on auth status
String? optionalAuthGuard(BuildContext context, GoRouterState state) {
  final container = ProviderScope.containerOf(context);

  // Get current auth state
  final authState = container.read(authNotifierProvider);

  // Log current state for debugging
  final isAuthenticated = authState.valueOrNull?.isAuthenticated ?? false;
  AppLogger.debug(
    'Optional auth guard: User ${isAuthenticated ? "is" : "is not"} authenticated',
  );

  // No redirect needed - allow access for everyone
  return null;
}

/// Helper function to get redirect location from query parameters
String? getRedirectLocation(GoRouterState state) {
  final redirect = state.uri.queryParameters['redirect'];
  if (redirect != null && redirect.isNotEmpty) {
    AppLogger.debug('Found redirect location: $redirect');
    return redirect;
  }
  return null;
}

/// Helper function to check if user is trying to access protected route
bool isProtectedRoute(String location) {
  const protectedRoutes = [
    '/home',
    '/profile',
    '/habits',
    '/statistics',
  ];

  return protectedRoutes.any((route) => location.startsWith(route));
}

/// Helper function to check if route is for guests only
bool isGuestOnlyRoute(String location) {
  const guestOnlyRoutes = [
    '/login',
    '/register',
    '/forgot-password',
  ];

  return guestOnlyRoutes.any((route) => location.startsWith(route));
}
