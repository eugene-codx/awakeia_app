import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../providers/auth_providers.dart';

/// Loading screen shown while checking authentication status
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
    AppLogger.info(
      'AuthLoadingScreen.initState: AuthLoadingScreen initialized',
    );
  }

  void _navigateBasedOnAuthState() {
    if (_hasNavigated || !mounted) return;

    final authAsyncValue = ref.read(authNotifierProvider);

    authAsyncValue.whenOrNull(
      data: (authState) {
        if (authState.isAuthenticated) {
          AppLogger.info(
            'AuthLoadingScreen._navigateBasedOnAuthState: User authenticated, navigating to home',
          );
          _hasNavigated = true;
          // Using GoRouter to navigate
          // This will replace the current route with the home screen
          // instead of pushing a new one
          context.goToHome();
        } else if (authState.isUnauthenticated) {
          AppLogger.info(
            'AuthLoadingScreen._navigateBasedOnAuthState: : User not authenticated, navigating to first',
          );
          _hasNavigated = true;
          context.goToFirst();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes and navigate accordingly
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          AppLogger.debug(
            'AuthLoadingScreen.build(ref.listen): Auth state changed, checking navigation',
          );
          _navigateBasedOnAuthState();
        },
      );
    });

    // Also check auth state after the first frame is built to ensure we don't miss any changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasNavigated) {
        _navigateBasedOnAuthState();
      }
    });

    // Get state for UI
    final authAsyncValue = ref.watch(authNotifierProvider);
    final hasError = authAsyncValue.hasError;

    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo
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

              // Show loading indicator or error
              if (hasError) ...[
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.error,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Error loading app',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () {
                    _hasNavigated = false;
                    // Try again
                    ref.invalidate(authNotifierProvider);
                  },
                  child: const Text('Retry'),
                ),
              ] else ...[
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Loading...',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    AppLogger.info('AuthLoadingScreen.dispose: AuthLoadingScreen disposed');
    super.dispose();
  }
}
