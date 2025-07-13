import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';
import '../utils/localization_helper.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get localization instance using extension
    final l10n = context.l10n;

    return Scaffold(
      // Using centralized gradient background
      body: DecoratedBox(
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

                // App title using localized text
                Text(
                  l10n.appName,
                  style: AppTextStyles.headline1,
                ),

                const SizedBox(height: AppSpacing.sm),

                // App subtitle using localized text
                Text(
                  l10n.appSubtitle,
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Login button with localized text
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to login screen using go_router
                      context.go('/login');
                    },
                    child: Text(
                      l10n.login,
                      style: AppTextStyles.buttonLarge,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Register button with localized text
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to register screen using go_router
                      context.go('/register');
                    },
                    child: Text(
                      l10n.register,
                      style: AppTextStyles.buttonLarge.copyWith(
                        color: AppColors.secondaryButtonText,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Continue as guest button with localized text
                TextButton(
                  onPressed: () {
                    // Navigate directly to home screen
                    context.go('/home');
                  },
                  child: Text(
                    l10n.continueAsGuest,
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
