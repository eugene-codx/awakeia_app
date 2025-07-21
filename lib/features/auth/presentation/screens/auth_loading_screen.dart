import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    // Check auth status after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  void _checkAuthStatus() {
    final authState = ref.read(authNotifierProvider);

    // Handle the current auth state
    authState.when(
      data: (state) {
        if (!_hasNavigated) {
          _navigateBasedOnAuthState(state);
        }
      },
      loading: () {
        // Still loading, wait for state to resolve
        AppLogger.debug('AuthLoadingScreen: Auth state is loading');
      },
      error: (error, stack) {
        AppLogger.error('AuthLoadingScreen: Error checking auth', error, stack);
        // On error, navigate to first screen
        if (!_hasNavigated) {
          _hasNavigated = true;
          context.go('/first');
        }
      },
    );
  }

  void _navigateBasedOnAuthState(state) {
    AppLogger.debug('AuthLoadingScreen: Navigating based on auth state');

    state.when(
      initial: () {
        AppLogger.debug('AuthLoadingScreen: Auth state is initial');
        // Wait for actual state
      },
      loading: () {
        AppLogger.debug('AuthLoadingScreen: Auth state is loading');
        // Wait for loading to complete
      },
      authenticated: (user) {
        AppLogger.info(
            'AuthLoadingScreen: User authenticated, navigating to home',);
        _hasNavigated = true;
        context.go('/home');
      },
      unauthenticated: (_) {
        AppLogger.info(
            'AuthLoadingScreen: User not authenticated, navigating to first',);
        _hasNavigated = true;
        context.go('/first');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes
    ref.listen(authNotifierProvider, (previous, next) {
      if (!_hasNavigated) {
        next.when(
          data: (authState) {
            _navigateBasedOnAuthState(authState);
          },
          loading: () {
            // Still loading
          },
          error: (error, stack) {
            AppLogger.error(
                'AuthLoadingScreen: Error in auth state', error, stack,);
            if (!_hasNavigated) {
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
