import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../controllers/auth_loading_controller.dart';
import '../providers/auth_providers.dart';

/// Loading screen shown while checking authentication status
class AuthLoadingScreen extends ConsumerStatefulWidget {
  const AuthLoadingScreen({super.key});

  @override
  ConsumerState<AuthLoadingScreen> createState() => _AuthLoadingScreenState();
}

class _AuthLoadingScreenState extends ConsumerState<AuthLoadingScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('AuthLoadingScreen initialized');

    // Проверяем auth статус после построения виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authLoadingControllerProvider.notifier).checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Слушаем необходимость навигации
    ref.listen(shouldNavigateProvider, (previous, next) {
      if (next != null && mounted) {
        AppLogger.info('AuthLoadingScreen: Navigating to ${next.name}');

        switch (next) {
          case NavigationTarget.home:
            context.go('/home');
            break;
          case NavigationTarget.first:
            context.go('/first');
            break;
        }
      }
    });

    // Получаем состояние
    final isCheckingAuth = ref.watch(isCheckingAuthProvider);
    final error = ref.watch(authLoadingErrorProvider);

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

              // Показываем индикатор загрузки или ошибку
              if (error != null) ...[
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
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  error,
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () {
                    // Сбрасываем состояние и пробуем снова
                    ref.invalidate(authNotifierProvider);
                    ref.invalidate(authLoadingControllerProvider);
                  },
                  child: const Text('Retry'),
                ),
              ] else if (isCheckingAuth) ...[
                // Loading indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
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
