import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/extensions/navigation_extensions.dart';
import '../core/logging/app_logger.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../shared/shared.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  bool _isSigningInAsGuest = false;

  @override
  void initState() {
    super.initState();
    AppLogger.info('FirstScreen initialized');
  }

  @override
  void dispose() {
    AppLogger.info('FirstScreen disposed');
    super.dispose();
  }

  Future<void> _handleGuestLogin() async {
    if (_isSigningInAsGuest) return;

    setState(() => _isSigningInAsGuest = true);

    try {
      final signInAsGuest = ref.read(signInAsGuestActionProvider);
      await signInAsGuest();

      if (mounted) {
        context.goToHome();
      }
    } finally {
      if (mounted) {
        setState(() => _isSigningInAsGuest = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get localization instance using extension
    final l10n = context.l10n;

    // Check if user is authenticated
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final currentUser = ref.watch(currentUserProvider);
    final isLoading = ref.watch(isAuthLoadingProvider) || _isSigningInAsGuest;

    // Listen for auth errors
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          if (authState.isUnauthenticated && authState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(authState.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
      );
    });

    return Scaffold(
      // Using centralized gradient background
      body: GradientBackground(
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

                // Show different buttons based on authentication status
                if (isAuthenticated) ...[
                  // Welcome back message
                  PrimaryCard(
                    padding: AppSpacing.paddingLG,
                    child: Column(
                      children: [
                        Text(
                          currentUser?.isGuest == true
                              ? l10n.welcomeGuest
                              : l10n.welcomeUser(
                                  currentUser?.displayName ?? 'User',
                                ),
                          style: AppTextStyles.headline5,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'You are already signed in',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Continue to app button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => context.goToHome(),
                      child: Text(
                        'Continue to App',
                        style: AppTextStyles.buttonLarge,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Sign out button
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            final signOut = ref.read(signOutActionProvider);
                            await signOut();
                          },
                    child: Text(
                      'Sign Out',
                      style: AppTextStyles.linkSecondary,
                    ),
                  ),
                ] else ...[
                  // Login button with localized text
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => context.goToLogin(),
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
                      onPressed:
                          isLoading ? null : () => context.goToRegister(),
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
                    onPressed: isLoading ? null : _handleGuestLogin,
                    child: isLoading && _isSigningInAsGuest
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primaryText,
                              ),
                            ),
                          )
                        : Text(
                            l10n.continueAsGuest,
                            style: AppTextStyles.linkSecondary,
                          ),
                  ),
                ],

                const SizedBox(height: AppSpacing.lg),

                // Demo button (only in debug mode)
                if (const bool.fromEnvironment('dart.vm.product') == false) ...[
                  TextButton(
                    onPressed: isLoading ? null : () => context.go('/demo'),
                    child: Text(
                      'Demo Widgets',
                      style: AppTextStyles.linkSecondary.copyWith(
                        color: AppColors.secondaryText.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
