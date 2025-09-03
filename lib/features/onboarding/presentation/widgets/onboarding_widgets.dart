// lib/features/onboarding/presentation/widgets/onboarding_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../shared/shared.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../application/onboarding_notifier.dart';
import '../../domain/entities/onboarding_entity.dart';

/// App logo widget
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: AppDecorations.primaryGradient,
      child: const Icon(
        Icons.self_improvement,
        size: 60,
        color: AppColors.primaryText,
      ),
    );
  }
}

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

/// Widget onboarding
class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key, required this.entity});
  final OnboardingEntity entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return Column(
      children: [
        // Welcome message for authenticated user
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

        const SizedBox(height: AppSpacing.lg),
        // Пропустить
        TextButton(
          onPressed: () async {
            await notifier.skip();
          },
          child: const Text('Пропустить'),
        ),

        // Далее / Завершить
        ElevatedButton(
          onPressed: () async {
            await notifier.nextStep();
          },
          child: Text(
            entity.currentStep + 1 == entity.totalSteps ? 'Завершить' : 'Далее',
          ),
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

/// Widget for unauthenticated state
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
    final isLoadingAuth = ref.watch(isAuthLoadingProvider);

    return Column(
      children: [
        // Sign in button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (isLoading || isLoadingAuth) ? null : onLogin,
            child: Text(
              l10n.login,
              style: AppTextStyles.buttonLarge,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Register button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: (isLoading || isLoadingAuth) ? null : onRegister,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              side: const BorderSide(color: AppColors.mediumPurple),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDecorations.radiusLarge),
              ),
            ),
            child: Text(
              l10n.register,
              style: AppTextStyles.buttonLarge.copyWith(
                color: AppColors.mediumPurple,
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        // Divider with text
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.divider),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'OR',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.divider),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        // Continue as guest button
        TextButton(
          onPressed: (isLoading || isLoadingAuth) ? null : onGuestLogin,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondaryText,
                    ),
                  ),
                )
              : Text(
                  l10n.continueAsGuest,
                  style: AppTextStyles.link.copyWith(
                    color: (isLoading || isLoadingAuth)
                        ? AppColors.secondaryText.withValues(alpha: 0.5)
                        : AppColors.secondaryText,
                  ),
                ),
        ),

        const SizedBox(height: AppSpacing.xxl),

        // Social login section (coming soon)
        _SocialLoginSection(isDisabled: isLoading || isLoadingAuth),
      ],
    );
  }
}

/// Social login buttons section
class _SocialLoginSection extends StatelessWidget {
  const _SocialLoginSection({required this.isDisabled});

  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Text(
          l10n.orSignInWith,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Social login buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google button
            _SocialButton(
              icon: Icons.g_mobiledata,
              label: l10n.google,
              onPressed: isDisabled
                  ? null
                  : () => context.showComingSoon(l10n.googleSignInComingSoon),
            ),

            const SizedBox(width: AppSpacing.md),

            // Facebook button
            _SocialButton(
              icon: Icons.facebook,
              label: l10n.facebook,
              onPressed: isDisabled
                  ? null
                  : () => context.showComingSoon(l10n.facebookSignInComingSoon),
            ),

            const SizedBox(width: AppSpacing.md),

            // Apple button (only on iOS)
            if (Theme.of(context).platform == TargetPlatform.iOS)
              _SocialButton(
                icon: Icons.apple,
                label: 'Apple',
                onPressed: isDisabled
                    ? null
                    : () => context.showComingSoon(l10n.appleSignInComingSoon),
              ),
          ],
        ),
      ],
    );
  }
}

/// Individual social login button
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryButton,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMedium),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.divider,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppDecorations.radiusMedium),
          ),
          child: Icon(
            icon,
            size: 24,
            color: onPressed == null
                ? AppColors.secondaryIcon.withValues(alpha: 0.5)
                : AppColors.secondaryIcon,
          ),
        ),
      ),
    );
  }
}
