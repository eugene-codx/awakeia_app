// ===== Auth Loading Screen =====
// lib/features/auth/presentation/screens/auth_loading_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/shared.dart';
import '../../../features.dart';
import '../providers/auth_providers.dart';

class AuthLoadingScreen extends ConsumerWidget {
  const AuthLoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to auth state changes for navigation
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
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
              const CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryText),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Loading...', style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
