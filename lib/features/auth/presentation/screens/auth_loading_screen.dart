import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../../../features.dart' hide AppLogo;

/// Loading screen shown during authentication check
///
/// This screen appears while the app checks if the user is authenticated.
/// It shows the app logo and loading indicator, then navigates based on auth state.
class AuthLoadingScreen extends ConsumerStatefulWidget {
  const AuthLoadingScreen({super.key});

  @override
  ConsumerState<AuthLoadingScreen> createState() => _AuthLoadingScreenState();
}

class _AuthLoadingScreenState extends ConsumerState<AuthLoadingScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    AppLogger.info('AuthLoadingScreen initialized');
  }

  /// Navigate based on authentication state
  void _navigateBasedOnAuthState() {
    if (_hasNavigated || !mounted) return;

    final authAsyncValue = ref.read(authProvider);

    authAsyncValue.whenOrNull(
      data: (authState) {
        authState.when(
          initial: () {
            AppLogger.debug(
              'AuthLoadingScreen: Initial state, staying on loading',
            );
          },
          loading: () {
            AppLogger.debug('AuthLoadingScreen: Loading, staying on loading');
          },
          authenticated: (_) {
            AppLogger.info(
              'AuthLoadingScreen: User authenticated, navigating to home',
            );
            _hasNavigated = true;
            context.goToHome();
          },
          unauthenticated: (_) {
            AppLogger.info(
              'AuthLoadingScreen: User not authenticated, navigating to first',
            );
            _hasNavigated = true;
            context.goToFirst();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes and navigate accordingly
    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          AppLogger.debug(
            'AuthLoadingScreen.build(ref.listen): Auth state changed, checking navigation',
          );
          _navigateBasedOnAuthState();
        },
      );
    });

    // Also check auth state after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasNavigated) {
        _navigateBasedOnAuthState();
      }
    });

    // Get state for UI
    final authAsyncValue = ref.watch(authProvider);
    final hasError = authAsyncValue.hasError;

    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo using new widget
              const AppLogo(size: AppLogoSize.large),

              const SizedBox(height: AppSpacing.xl),

              // Show loading or error state
              if (hasError)
                ErrorDisplay(
                  title: 'Authentication Error',
                  message: 'Failed to check authentication status',
                  onRetry: () {
                    ref.invalidate(authProvider);
                  },
                )
              else ...[
                // Loading indicator
                const AppLoadingIndicator(),

                const SizedBox(height: AppSpacing.md),

                // Loading text
                Text(
                  'Loading...',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
