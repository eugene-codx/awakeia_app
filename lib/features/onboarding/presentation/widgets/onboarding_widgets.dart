import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/shared.dart';
import '../providers/onboarding_providers.dart';

/// Виджет для аутентифицированного состояния
class AuthenticatedView extends ConsumerWidget {
  const AuthenticatedView({
    super.key,
    required this.onContinueToApp,
    required this.onSignOut,
    required this.isLoading,
  });

  final VoidCallback onContinueToApp;
  final VoidCallback onSignOut;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final welcomeMessage = ref.watch(welcomeOnboardingMessageProvider);

    return Column(
      children: [
        // Приветственное сообщение для аутентифицированного пользователя
        PrimaryCard(
          padding: AppSpacing.paddingLG,
          child: Column(
            children: [
              Text(
                welcomeMessage,
                style: AppTextStyles.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'You are already signed in',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Кнопка продолжения в приложение
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onContinueToApp,
            child: Text(
              'Continue to App',
              style: AppTextStyles.buttonLarge,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Кнопка выхода
        TextButton(
          onPressed: isLoading ? null : onSignOut,
          child: Text(
            'Sign Out',
            style: AppTextStyles.linkSecondary,
          ),
        ),
      ],
    );
  }
}

/// Виджет для неаутентифицированного состояния
class UnauthenticatedView extends ConsumerWidget {
  const UnauthenticatedView({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.onGuestLogin,
    required this.isLoading,
  });

  final VoidCallback onLogin;
  final VoidCallback onRegister;
  final VoidCallback onGuestLogin;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final isSigningInAsGuest = ref.watch(isSigningInAsGuestProvider);

    return Column(
      children: [
        // Кнопка входа
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onLogin,
            child: Text(
              l10n.login,
              style: AppTextStyles.buttonLarge,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Кнопка регистрации
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: isLoading ? null : onRegister,
            child: Text(
              l10n.register,
              style: AppTextStyles.buttonLarge.copyWith(
                color: AppColors.secondaryButtonText,
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Кнопка входа как гость
        TextButton(
          onPressed: isLoading ? null : onGuestLogin,
          child: isSigningInAsGuest
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
    );
  }
}
