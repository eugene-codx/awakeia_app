import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/auth.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../shared/shared.dart';

/// Loading screen shown while checking authentication status
class AuthLoadingScreen extends ConsumerWidget {
  const AuthLoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to auth state changes
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          // Navigate based on auth state
          authState.when(
            initial: () {}, // Do nothing, still initializing
            loading: () {}, // Do nothing, still loading
            authenticated: (_) => context.go('/home'),
            unauthenticated: (_) => context.go('/first'),
          );
        },
      );
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
