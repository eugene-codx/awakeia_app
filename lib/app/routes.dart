import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/logging/app_logger.dart';
import '../features/auth/auth.dart';
import '../features/auth/presentation/screens/auth_loading_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/onboarding/presentation/screens/first_screen.dart';
import '../shared/screens/route_error_screen.dart';
import '../shared/screens/widgets_demo_screen.dart';
import 'constants/route_constants.dart';

/// Provider for router configuration with simplified auth handling
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteConstants.loading,
    refreshListenable: _RouterRefreshStream(ref),
    redirect: (context, state) => _handleRedirect(ref, state),
    routes: _buildRoutes(),
    // Error page builder
    errorBuilder: (context, state) => RouteErrorScreen(
      error: state.error?.toString(),
    ),
    debugLogDiagnostics: kDebugMode,
    observers: [_LoggingNavigatorObserver()],
  );
});

// ===== Helper Functions =====

/// Handles redirect logic based on auth state
String? _handleRedirect(Ref ref, GoRouterState state) {
  final location = state.matchedLocation;
  AppLogger.debug('Router: Redirecting to location: $location');

  // Always allow loading screen
  if (location == RouteConstants.loading) {
    AppLogger.debug('Router: On loading screen, no redirect');
    return null;
  }

  // Check if auth is loading
  // Check authentication loading
  final authAsync = ref.read(authProvider);
  // if (authAsync.isLoading) {
  //   return RouteConstants.loading;
  // }

  // If there's an auth error (like login failure), don't redirect
  if (authAsync.hasError) {
    AppLogger.debug('Router: Auth error detected, staying on current route');
    return null;
  }

  // Get authentication state
  final authState = authAsync.valueOrNull;
  if (authState == null) return null;

  final isAuthenticated = authState.when(
    initial: () => false,
    loading: () => false,
    authenticated: (_) => true,
    unauthenticated: (_) => false,
  );

  // List of public routes (don't require authentication)
  final publicRoutes = {
    RouteConstants.loading, // '/'
    RouteConstants.first, // '/first'
    RouteConstants.login, // '/login'
    RouteConstants.register, // '/register'
    RouteConstants.forgotPassword, // '/forgot-password'
    '/demo', // development
  };

  // If user is NOT authenticated
  if (!isAuthenticated) {
    // Don't redirect if already on login/register page, especially if there's an auth error
    // This prevents redirecting users away from login screen when login fails
    if (location == RouteConstants.login ||
        location == RouteConstants.register) {
      return null;
    }
    // If trying to access protected route - redirect to /first
    if (!publicRoutes.contains(location)) {
      return RouteConstants.first;
    }
    // If on public route - allow
    return null;
  }

  // If user is authenticated and on auth routes - go to home
  if (isAuthenticated &&
      (location == RouteConstants.login ||
          location == RouteConstants.register ||
          location == RouteConstants.first)) {
    return RouteConstants.home;
  }

  AppLogger.debug('Router: No redirect needed');
  return null;
}

/// Builds all application routes
List<RouteBase> _buildRoutes() {
  return [
    // Core routes
    ..._buildCoreRoutes(),

    // Feature routes
    ..._buildFeatureRoutes(),

    // Auth routes
    ..._buildAuthRoutes(),

    // Habit routes
    ..._buildHabitRoutes(),

    // Development routes
    ..._buildDevelopmentRoutes(),
  ];
}

/// Core application routes
List<RouteBase> _buildCoreRoutes() {
  return [
    GoRoute(
      path: RouteConstants.loading,
      name: RouteNames.loading,
      builder: (context, state) => const AuthLoadingScreen(),
    ),
    GoRoute(
      path: RouteConstants.first,
      name: RouteNames.first,
      builder: (context, state) => const FirstScreen(),
    ),
    GoRoute(
      path: RouteConstants.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteConstants.register,
      name: RouteNames.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteConstants.home,
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ];
}

/// Feature-specific routes
List<RouteBase> _buildFeatureRoutes() {
  return [
    GoRoute(
      path: RouteConstants.profile,
      name: RouteNames.profile,
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Profile',
        featureName: 'Profile management',
      ),
    ),
    GoRoute(
      path: RouteConstants.habits,
      name: RouteNames.habits,
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Habits',
        featureName: 'Habit tracking',
      ),
    ),
    GoRoute(
      path: RouteConstants.statistics,
      name: RouteNames.statistics,
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Statistics',
        featureName: 'Statistics and analytics',
      ),
    ),
    GoRoute(
      path: RouteConstants.settings,
      name: RouteNames.settings,
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Settings',
        featureName: 'App settings',
      ),
    ),
  ];
}

/// Authentication-related routes
List<RouteBase> _buildAuthRoutes() {
  return [
    GoRoute(
      path: RouteConstants.forgotPassword,
      name: RouteNames.forgotPassword,
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Forgot Password',
        featureName: 'Password recovery',
      ),
    ),
    GoRoute(
      path: RouteConstants.verifyEmail,
      name: RouteNames.verifyEmail,
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Verify Email',
        featureName: 'Email verification',
      ),
    ),
  ];
}

/// Habit management routes
List<RouteBase> _buildHabitRoutes() {
  return [
    GoRoute(
      path: RouteConstants.createHabit,
      name: RouteNames.createHabit,
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Create Habit',
        featureName: 'Habit creation',
      ),
    ),
    GoRoute(
      path: '/habits/:id',
      name: RouteNames.habitDetails,
      builder: (context, state) {
        final habitId = state.pathParameters['id']!;
        return _PlaceholderScreen(
          title: 'Habit Details',
          featureName: 'Habit details for ID: $habitId',
        );
      },
    ),
  ];
}

/// Development-only routes
List<RouteBase> _buildDevelopmentRoutes() {
  if (const bool.fromEnvironment('dart.vm.product')) {
    return [];
  }

  return [
    GoRoute(
      path: '/demo',
      name: 'demo',
      builder: (context, state) => const WidgetsDemoScreen(),
    ),
  ];
}

/// Custom refresh listenable for router
class _RouterRefreshStream extends ChangeNotifier {
  _RouterRefreshStream(this._ref) {
    AppLogger.info(
      'Router.RouterRefreshStream: Initialized, listening to auth changes',
    );
    _ref.listen(
      authProvider,
      (
        _,
        __,
      ) =>
          notifyListeners(),
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
