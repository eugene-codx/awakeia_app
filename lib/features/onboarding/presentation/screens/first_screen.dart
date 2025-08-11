import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../presentation.dart';

/// First screen of the app (welcome/onboarding) using Clean Architecture
class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('_FirstScreenState.initState: FirstScreen initialized');
  }

  @override
  void dispose() {
    AppLogger.info('_FirstScreenState.dispose: FirstScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingNotifierProvider);
    final isLoading = ref.watch(onboardingLoadingProvider);

    // Listen for errors
    ref.listen(onboardingNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (state) {
          state.whenOrNull(
            error: (message) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
          );
        },
      );
    });

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // App logo and title
                const AppLogo(),
                const SizedBox(height: AppSpacing.lg),
                const AppTitle(),
                const SizedBox(height: AppSpacing.md),
                const AppSubtitle(),

                const Spacer(),

                // Main content based on state
                onboardingState.when(
                  data: (state) => state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    authenticated: (user, onboarding) => AuthenticatedView(
                      userName: user.displayName,
                      onContinueToApp: () => _handleContinueToApp(context),
                      onSignOut: () => _handleSignOut(context),
                      isLoading: isLoading,
                    ),
                    unauthenticated: (onboarding) => UnauthenticatedView(
                      onLogin: () => context.goToLogin(),
                      onRegister: () => context.goToRegister(),
                      onGuestLogin: () => _handleGuestLogin(context),
                      isLoading: isLoading,
                    ),
                    error: (message) => ErrorView(
                      message: message,
                      onRetry: () => _handleRetry(context),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => ErrorView(
                    message: error.toString(),
                    onRetry: () => _handleRetry(context),
                  ),
                ),

                const Spacer(),

                // Development mode indicator
                if (const bool.fromEnvironment('dart.vm.product') == false)
                  _DemoButton(isLoading: isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleContinueToApp(BuildContext context) async {
    // Complete onboarding if not already completed
    final onboarding = ref.read(currentOnboardingProvider);
    if (onboarding != null && !onboarding.isCompleted) {
      final completeAction = ref.read(completeOnboardingActionProvider);
      await completeAction();
    }

    if (context.mounted) {
      context.goToHome();
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final signOutAction = ref.read(signOutActionProvider);
    await signOutAction();
  }

  Future<void> _handleGuestLogin(BuildContext context) async {
    final continueAsGuestAction = ref.read(continueAsGuestActionProvider);
    await continueAsGuestAction();

    // Navigation will happen automatically after successful guest login
    if (context.mounted) {
      context.goToHome();
    }
  }

  void _handleRetry(BuildContext context) {
    // Refresh the onboarding state
    ref.invalidate(onboardingNotifierProvider);
  }
}

/// Demo button (only for development)
class _DemoButton extends ConsumerWidget {
  const _DemoButton({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: isLoading ? null : () => context.go('/demo'),
      child: Text(
        'Demo Widgets',
        style: AppTextStyles.linkSecondary.copyWith(
          color: AppColors.secondaryText.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

/// Error view widget
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.error_outline,
          size: 48,
          color: AppColors.error,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          message,
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
