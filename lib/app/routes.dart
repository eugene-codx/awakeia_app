import 'package:awakeia/screens/widgets_demo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/first_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

// Provider for router configuration
// This file defines the routes for the application using GoRouter.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    // First route - the first screen
    initialLocation: '/first',

    //
    // Determination of all application routes
    routes: [
      // First Screen - splash/onboarding
      GoRoute(
        path: '/first',
        name: 'first',
        builder: (context, state) => const FirstScreen(),
      ),

      // Login Screen
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Register Screen
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Home Screen
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Home Screen
      GoRoute(
        path: '/demo',
        name: 'demo',
        builder: (context, state) => const WidgetsDemoScreen(),
      ),
    ],

    // Processing redirects errors
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Path: ${state.uri}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/first'),
              child: const Text('To main page'),
            ),
          ],
        ),
      ),
    ),
  );
});
