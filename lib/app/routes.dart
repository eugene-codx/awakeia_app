import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/logging/app_logger.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../features/auth/presentation/screens/auth_loading_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/onboarding/presentation/screens/first_screen.dart';
import '../shared/screens/route_error_screen.dart';
import '../shared/screens/widgets_demo_screen.dart';
import 'guards/auth_guards.dart';

// Provider for router configuration with auth state listening
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    // Always start from loading screen
    initialLocation: '/',

    // Refresh listener for auth state changes
    refreshListenable: _RouterRefreshStream(ref),

// Global redirect for auth state changes
    redirect: (context, state) {
      final location = state.matchedLocation;

      // Always allow loading screen
      if (location == '/') {
        AppLogger.debug('Router: On loading screen, no redirect');
        return null;
      }

      // Check auth state
      final authAsyncValue = ref.read(authNotifierProvider);

      // If auth is still loading, redirect to loading screen
      if (authAsyncValue.isLoading) {
        AppLogger.debug(
          'Router: Auth still loading, redirecting to loading screen',
        );
        return '/';
      }

      // Get the actual auth state
      final authState = authAsyncValue.valueOrNull;

      // If we don't have auth state yet, go to loading screen
      if (authState == null) {
        AppLogger.debug('Router: No auth state, redirecting to loading screen');
        return '/';
      }

      // Now check authentication status
      final isAuthenticated = authState.isAuthenticated;
      AppLogger.debug(
        'Router: Auth state - isAuthenticated: $isAuthenticated, location: $location',
      );

      // Check if trying to access protected route without auth
      if (!isAuthenticated && isProtectedRoute(location)) {
        AppLogger.info(
          'Router: Redirecting to login from protected route: $location',
        );
        return '/login?redirect=$location';
      }

      // Check if authenticated user trying to access guest-only route
      if (isAuthenticated && isGuestOnlyRoute(location)) {
        AppLogger.info(
          'Router: Redirecting to home from guest route: $location',
        );
        return '/home';
      }

      return null;
    },

    // Route definitions
    routes: [
      // Loading route - shown while checking auth
      GoRoute(
        path: '/',
        name: 'loading',
        builder: (context, state) => const AuthLoadingScreen(),
      ),

      // First Screen - welcome/onboarding
      GoRoute(
        path: '/first',
        name: 'first',
        builder: (context, state) => const FirstScreen(),
        redirect: optionalAuthGuard,
      ),

      // Login Screen
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
        redirect: guestGuard,
      ),

      // Register Screen
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
        redirect: guestGuard,
      ),

      // Home Screen - requires authentication
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        redirect: authGuard,
      ),

      // Feature placeholder screens
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Profile',
          featureName: 'Profile management',
        ),
        redirect: authGuard,
      ),

      GoRoute(
        path: '/habits',
        name: 'habits',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Habits',
          featureName: 'Habit tracking',
        ),
        redirect: authGuard,
      ),

      GoRoute(
        path: '/statistics',
        name: 'statistics',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Statistics',
          featureName: 'Statistics and analytics',
        ),
        redirect: authGuard,
      ),

      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Settings',
          featureName: 'App settings',
        ),
        redirect: authGuard,
      ),

      // Demo Screen (only for development)
      if (const bool.fromEnvironment('dart.vm.product') == false)
        GoRoute(
          path: '/demo',
          name: 'demo',
          builder: (context, state) => const WidgetsDemoScreen(),
        ),

      // Auth feature nested routes
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Forgot Password',
          featureName: 'Password recovery',
        ),
        redirect: guestGuard,
      ),

      GoRoute(
        path: '/verify-email',
        name: 'verify-email',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Verify Email',
          featureName: 'Email verification',
        ),
      ),

      // Habit management routes
      GoRoute(
        path: '/habits/create',
        name: 'create-habit',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Create Habit',
          featureName: 'Habit creation',
        ),
        redirect: authGuard,
      ),

      GoRoute(
        path: '/habits/:id',
        name: 'habit-details',
        builder: (context, state) {
          final habitId = state.pathParameters['id']!;
          return _PlaceholderScreen(
            title: 'Habit Details',
            featureName: 'Habit details for ID: $habitId',
          );
        },
        redirect: authGuard,
      ),
    ],

    // Error page builder
    errorBuilder: (context, state) => RouteErrorScreen(
      error: state.error?.toString(),
    ),

    // Debug logging
    debugLogDiagnostics: true,

    // Navigation observers
    observers: [
      _LoggingNavigatorObserver(),
    ],
  );
});

/// Helper functions to check route types
bool isProtectedRoute(String location) {
  const protectedRoutes = [
    '/home',
    '/profile',
    '/habits',
    '/statistics',
    '/settings',
  ];
  return protectedRoutes.any((route) => location.startsWith(route));
}

bool isGuestOnlyRoute(String location) {
  const guestOnlyRoutes = [
    '/login',
    '/register',
    '/forgot-password',
  ];
  return guestOnlyRoutes.any((route) => location.startsWith(route));
}

/// Custom refresh listenable for router
class _RouterRefreshStream extends ChangeNotifier {
  _RouterRefreshStream(this._ref) {
    // Listen to auth state changes
    _ref.listen(
      authNotifierProvider,
      (_, __) => notifyListeners(),
    );
  }

  final Ref _ref;
}

/// Navigator observer for logging navigation events
class _LoggingNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.navigation(
      'Pushed: ${route.settings.name} (from: ${previousRoute?.settings.name})',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.navigation(
      'Popped: ${route.settings.name} (to: ${previousRoute?.settings.name})',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.navigation(
      'Removed: ${route.settings.name} (previous: ${previousRoute?.settings.name})',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    AppLogger.navigation(
      'Replaced: ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
    );
  }
}

/// Placeholder screen for features that are not yet implemented
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({
    required this.title,
    required this.featureName,
  });

  final String title;
  final String featureName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              '$featureName coming soon!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'This feature is under development',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
