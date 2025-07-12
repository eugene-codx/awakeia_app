import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using centralized gradient background
      body: Container(
        decoration: AppDecorations.primaryGradient,
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Spacer to push content to center
                const Spacer(),

                // App logo/icon placeholder using centralized styles
                Container(
                  width: 120,
                  height: 120,
                  decoration: AppDecorations.logoContainer,
                  child: const Icon(
                    Icons.self_improvement,
                    size: 64,
                    color: AppColors.primaryIcon,
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // App title using centralized text style
                Text(
                  'Awakeia',
                  style: AppTextStyles.headline1,
                ),

                const SizedBox(height: AppSpacing.sm),

                // App subtitle using centralized text style
                Text(
                  'Your personal habit tracker',
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Login button - now uses theme automatically
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to login screen using go_router
                      context.go('/login');
                    },
                    child: Text(
                      'Login',
                      style: AppTextStyles.buttonLarge,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Register button - now uses theme automatically
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to register screen using go_router
                      context.go('/register');
                    },
                    child: Text(
                      'Register',
                      style: AppTextStyles.buttonLarge.copyWith(
                        color: AppColors.secondaryButtonText,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Continue as guest button
                TextButton(
                  onPressed: () {
                    // Navigate directly to home screen
                    context.go('/home');
                  },
                  child: Text(
                    'Continue as Guest',
                    style: AppTextStyles.linkSecondary,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Continue as guest button
                TextButton(
                  onPressed: () {
                    // Navigate directly to demo screen
                    context.go('/demo');
                  },
                  child: Text(
                    'Demo Widgets',
                    style: AppTextStyles.linkSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
