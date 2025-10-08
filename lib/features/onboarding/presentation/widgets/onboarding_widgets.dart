// lib/features/onboarding/presentation/widgets/onboarding_widgets.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/shared.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../application/onboarding_notifier.dart';
import '../../domain/entities/onboarding_entity.dart';

// Re-export AppLogo from common_widgets for backwards compatibility
export '../../../../shared/widgets/common_widgets.dart'
    show AppLogo, AppLogoSize;

/// App title widget
class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Text(
      l10n.appName,
      style: AppTextStyles.headline3,
      textAlign: TextAlign.center,
    );
  }
}

/// App subtitle widget
class AppSubtitle extends StatelessWidget {
  const AppSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Text(
      l10n.appSubtitle,
      style: AppTextStyles.subtitle,
      textAlign: TextAlign.center,
    );
  }
}

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key, required this.entity});

  final OnboardingEntity entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return Column(
      children: [
        // Контент текущего шага
        SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              _stepText(entity.currentStep),
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Индикатор прогресса
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            entity.totalSteps,
            (index) => Container(
              margin: const EdgeInsets.all(4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index <= entity.currentStep
                    ? Colors.blue
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        // Кнопки навигации - используем общие виджеты

        // Далее / Завершить - PrimaryButton
        PrimaryButton(
          text: entity.currentStep + 1 == entity.totalSteps
              ? 'Завершить'
              : 'Далее',
          icon: entity.currentStep + 1 == entity.totalSteps
              ? Icons.check
              : Icons.arrow_forward,
          onPressed: () async {
            await notifier.nextStep();
          },
        ),

        const SizedBox(height: AppSpacing.sm),

        TextButton(
          onPressed: () async {
            await notifier.skip();
          },
          child: const Text('Пропустить'),
        ),
      ],
    );
  }

  String _stepText(int step) {
    switch (step) {
      case 0:
        return 'Добро пожаловать! 👋\n\nЭто первый шаг онбординга.';
      case 1:
        return 'Здесь рассказываем о возможностях приложения 📱';
      case 2:
        return 'А тут подталкиваем зарегистрироваться 🚀';
      default:
        return 'Неизвестный шаг';
    }
  }
}

/// Widget for unauthenticated state - МЕНЯЕМ ТОЛЬКО КНОПКИ
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
    // Исправляем провайдер - берем из authProvider
    final authState = ref.watch(authProvider);
    final isLoadingAuth = authState.isLoading;

    return Column(
      children: [
        // Register button - используем PrimaryButton
        PrimaryButton(
          text: l10n.register,
          icon: Icons.person_add,
          onPressed: (isLoading || isLoadingAuth) ? null : onRegister,
        ),

        const SizedBox(height: AppSpacing.md),

        // Login button - используем SecondaryButton
        SecondaryButton(
          text: l10n.login,
          icon: Icons.login,
          onPressed: (isLoading || isLoadingAuth) ? null : onLogin,
        ),

        const SizedBox(height: AppSpacing.lg),

        // Divider - используем общий виджет
        const SectionDivider(title: 'OR'),

        const SizedBox(height: AppSpacing.lg),

        // Guest login button - оставляем как TextButton
        TextButton(
          onPressed: (isLoading || isLoadingAuth) ? null : onGuestLogin,
          child: Text(
            l10n.continueAsGuest,
            style: AppTextStyles.linkPrimary,
          ),
        ),
      ],
    );
  }
}
