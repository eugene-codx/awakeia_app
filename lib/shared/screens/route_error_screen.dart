// lib/shared/screens/route_error_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';
import '../widgets/common_widgets.dart';

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
                // Error icon
                const Icon(
                  Icons.error_outline,
                  size: 80,
                  color: AppColors.error,
                ),

                const SizedBox(height: AppSpacing.lg),

                // Error title
                Text(
                  'Oops! Something went wrong',
                  style: AppTextStyles.headline4,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.md),

                // Error message
                Text(
                  error ?? 'The page you are looking for could not be found.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xl),

                // Action buttons
                Column(
                  children: [
                    // Go home button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.go('/home'),
                        child: const Text('Go to Home'),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Go back button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/first');
                          }
                        },
                        child: const Text('Go Back'),
                      ),
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
