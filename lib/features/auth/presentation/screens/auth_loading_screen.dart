import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';

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
    AppLogger.info('AuthLoadingScreen initialized');
    // Check auth status after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  /// Check initial auth status and navigate
  void _checkAuthStatus() {
    if (_hasNavigated) return;

    AppLogger.debug('AuthLoadingScreen: Checking auth status');
    final authAsyncValue = ref.read(authNotifierProvider);

    // Handle the AsyncValue properly
    authAsyncValue.when(
      data: (authState) {
        AppLogger.debug('AuthLoadingScreen: Auth state data received');
        _navigateBasedOnAuthState(authState);
      },
      loading: () {
        AppLogger.debug('AuthLoadingScreen: Auth state is loading');
        // Still loading, wait for state to resolve
      },
      error: (error, stack) {
        AppLogger.error('AuthLoadingScreen: Error checking auth', error, stack);
        // On error, navigate to first screen
        if (!_hasNavigated && mounted) {
          _hasNavigated = true;
          context.go('/first');
        }
      },
    );
  }

  /// Navigate based on the auth state
  void _navigateBasedOnAuthState(AuthState authState) {
    if (_hasNavigated || !mounted) return;

    AppLogger.debug(
        'AuthLoadingScreen: Processing auth state: ${authState.runtimeType}',);

    // Use pattern matching properly for AuthState
    if (authState.isInitial) {
      AppLogger.debug('AuthLoadingScreen: Auth state is initial, waiting...');
      // Wait for actual state
      return;
    } else if (authState.isLoading) {
      AppLogger.debug('AuthLoadingScreen: Auth state is loading, waiting...');
      // Wait for loading to complete
      return;
    } else if (authState.isAuthenticated) {
      AppLogger.info(
          'AuthLoadingScreen: User authenticated, navigating to home',);
      _hasNavigated = true;
      context.go('/home');
    } else if (authState.isUnauthenticated) {
      AppLogger.info(
          'AuthLoadingScreen: User not authenticated, navigating to first',);
      _hasNavigated = true;
      context.go('/first');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes
    ref.listen(authNotifierProvider, (previous, next) {
      AppLogger.debug('AuthLoadingScreen: Auth state changed');

      if (!_hasNavigated) {
        next.when(
          data: (authState) {
            AppLogger.debug(
                'AuthLoadingScreen: New auth state received in listener',);
            _navigateBasedOnAuthState(authState);
          },
          loading: () {
            AppLogger.debug(
                'AuthLoadingScreen: Auth state loading in listener',);
            // Still loading
          },
          error: (error, stack) {
            AppLogger.error('AuthLoadingScreen: Error in auth state listener',
                error, stack,);
            if (!_hasNavigated && mounted) {
              _hasNavigated = true;
              context.go('/first');
            }
          },
        );
      }
    });

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

              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryText,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Loading text
              Text(
                'Loading...',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
