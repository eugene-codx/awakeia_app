import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/logging/app_logger.dart';
import '../features/auth/auth.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../features/auth/presentation/screens/auth_loading_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/onboarding/presentation/screens/first_screen.dart';
import '../screens/widgets_demo_screen.dart'; // Временно оставляем для демо
import '../shared/screens/route_error_screen.dart';
import 'guards/auth_guards.dart';

// Provider for router configuration with auth state listening
final routerProvider = Provider<GoRouter>((ref) {
  // Watch auth state to rebuild router when auth changes
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    // Initial location depends on auth state
    initialLocation: authState.when(
      data: (state) => state.when(
        initial: () => '/',
        loading: () => '/',
        authenticated: (_) => '/home',
        unauthenticated: (_) => '/first',
      ),
      loading: () => '/',
      error: (_, __) => '/first',
    ),

    // Refresh listener for auth state changes
    refreshListenable: _RouterRefreshStream(ref),

    // Global redirect for auth state changes
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final authStateValue = authState.valueOrNull;

      // Show loading screen while checking auth
      if (isLoading || authStateValue == null) {
        return '/';
      }

      final isAuthenticated = authStateValue.isAuthenticated;
      final isOnLoadingPage = state.matchedLocation == '/';

      // Redirect from loading page once auth state is determined
      if (isOnLoadingPage && !isLoading) {
        return isAuthenticated ? '/home' : '/first';
      }

      // Apply route-specific guards
      final location = state.matchedLocation;

      // Check if trying to access protected route without auth
      if (!isAuthenticated && isProtectedRoute(location)) {
        AppLogger.info('Redirecting to login from protected route: $location');
        return '/login?redirect=$location';
      }

      // Check if authenticated user trying to access guest-only route
      if (isAuthenticated && isGuestOnlyRoute(location)) {
        AppLogger.info('Redirecting to home from guest route: $location');
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

      // Feature placeholder screens (для будущих feature модулей)
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

      // Settings Screen (placeholder)
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const _PlaceholderScreen(
          title: 'Settings',
          featureName: 'App settings',
        ),
        redirect: authGuard,
      ),

      // Demo Screen (только для разработки)
      if (const bool.fromEnvironment('dart.vm.product') == false)
        GoRoute(
          path: '/demo',
          name: 'demo',
          builder: (context, state) => const WidgetsDemoScreen(),
        ),

      // Auth feature nested routes (для будущего расширения)
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

      // Habit management routes (для будущего)
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

/// Placeholder screen для будущих feature модулей
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              Text(
                '$title Screen',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$featureName will be implemented in future versions.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
