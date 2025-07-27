// lib/features/auth/presentation/screens/auth_loading_screen.dart
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
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    AppLogger.info('AuthLoadingScreen initialized');

    // Проверяем auth статус после построения виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authLoadingControllerProvider.notifier).checkAuthStatus();
    });
  }

  void _navigateBasedOnAuthState() {
    if (_hasNavigated || !mounted) return;

    final authAsyncValue = ref.read(authNotifierProvider);

    authAsyncValue.whenOrNull(
      data: (authState) {
        if (authState.isAuthenticated) {
          AppLogger.info(
              'AuthLoadingScreen: User authenticated, navigating to home',);
          _hasNavigated = true;
          // Используем pushReplacement чтобы заменить loading screen
          GoRouter.of(context).go('/home');
        } else if (authState.isUnauthenticated) {
          AppLogger.info(
              'AuthLoadingScreen: User not authenticated, navigating to first',);
          _hasNavigated = true;
          GoRouter.of(context).go('/first');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Слушаем изменения auth state и навигируем когда готово
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          AppLogger.debug(
              'AuthLoadingScreen: Auth state changed, checking navigation',);
          _navigateBasedOnAuthState();
        },
      );
    });

    // Также проверяем при каждом build (на случай если состояние уже есть)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasNavigated) {
        _navigateBasedOnAuthState();
      }
    });

    // Получаем состояние для UI
    final controller = ref.watch(authLoadingControllerProvider);
    final error = controller.error;

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
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () {
                    _hasNavigated = false;
                    // Пробуем снова
                    ref.invalidate(authNotifierProvider);
                    ref
                        .read(authLoadingControllerProvider.notifier)
                        .checkAuthStatus();
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
    AppLogger.info('AuthLoadingScreen disposed');
    super.dispose();
  }
}
