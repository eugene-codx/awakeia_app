// lib/shared/screens/route_error_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shared.dart';

/// Error screen shown when navigation fails or route not found
class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({
    super.key,
    this.error,
  });

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Error display using new widget
                ErrorDisplay(
                  title: 'Page Not Found',
                  message: error ??
                      'The page you are looking for could not be found.',
                  icon: Icons.error_outline,
                ),

                const SizedBox(height: AppSpacing.xl),

                // Action buttons
                Column(
                  children: [
                    // Go home button
                    PrimaryButton(
                      text: 'Go to Home',
                      icon: Icons.home,
                      onPressed: () => context.go('/home'),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Go back button
                    SecondaryButton(
                      text: 'Go Back',
                      icon: Icons.arrow_back,
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/first');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
