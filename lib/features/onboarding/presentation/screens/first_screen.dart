import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../providers/onboarding_providers.dart';
import '../widgets/onboarding_widgets.dart';

/// Первый экран приложения (welcome/onboarding) с использованием Clean Architecture
class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('FirstScreen initialized');
  }

  @override
  void dispose() {
    AppLogger.info('FirstScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = ref.watch(onboardingIsAuthenticatedProvider);
    final showAuthenticatedView = ref.watch(showAuthenticatedViewProvider);
    final isLoading = ref.watch(onboardingOverallLoadingProvider);

    // Слушаем ошибки onboarding view model
    ref.listen(onboardingErrorProvider, (previous, current) {
      if (current != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(current),
            backgroundColor: AppColors.error,
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: AppColors.primaryText,
              onPressed: () {
                ref.read(clearOnboardingErrorActionProvider)();
              },
            ),
          ),
        );
      }
    });

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Spacer для центрирования
                const Spacer(),

                // Логотип приложения
                _AppLogo(),

                const SizedBox(height: AppSpacing.xl),

                // Название приложения
                _AppTitle(),

                const SizedBox(height: AppSpacing.sm),

                // Подзаголовок приложения
                _AppSubtitle(),

                const Spacer(),

                // Основной контент в зависимости от состояния аутентификации
                _MainContent(
                  showAuthenticatedView: showAuthenticatedView,
                  isLoading: isLoading,
                ),

                const SizedBox(height: AppSpacing.lg),

                // Демо кнопка (только в debug режиме)
                if (const bool.fromEnvironment('dart.vm.product') == false) ...[
                  _DemoButton(isLoading: isLoading),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Логотип приложения
class _AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: AppDecorations.logoContainer,
      child: const Icon(
        Icons.self_improvement,
        size: 64,
        color: AppColors.primaryIcon,
      ),
    );
  }
}

/// Название приложения
class _AppTitle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Text(
      l10n.appName,
      style: AppTextStyles.headline1,
    );
  }
}

/// Подзаголовок приложения
class _AppSubtitle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Text(
      l10n.appSubtitle,
      style: AppTextStyles.subtitle,
      textAlign: TextAlign.center,
    );
  }
}

/// Основной контент экрана
class _MainContent extends StatelessWidget {
  const _MainContent({
    required this.showAuthenticatedView,
    required this.isLoading,
  });

  final bool showAuthenticatedView;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (showAuthenticatedView) {
      return AuthenticatedView(
        onContinueToApp: () => context.goToHome(),
        onSignOut: () => _handleSignOut(context),
        isLoading: isLoading,
      );
    } else {
      return UnauthenticatedView(
        onLogin: () => context.goToLogin(),
        onRegister: () => context.goToRegister(),
        onGuestLogin: () => _handleGuestLogin(context),
        isLoading: isLoading,
      );
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final container = ProviderScope.containerOf(context);
    final signOutAction = container.read(onboardingSignOutActionProvider);
    await signOutAction();
  }

  Future<void> _handleGuestLogin(BuildContext context) async {
    final container = ProviderScope.containerOf(context);
    final guestSignInAction =
        container.read(onboardingSignInAsGuestActionProvider);
    await guestSignInAction();

    // Навигация произойдет автоматически после успешного входа
    if (context.mounted) {
      context.goToHome();
    }
  }
}

/// Демо кнопка (только для разработки)
class _DemoButton extends ConsumerWidget {
  const _DemoButton({
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: isLoading ? null : () => context.go('/demo'),
      child: Text(
        'Demo Widgets',
        style: AppTextStyles.linkSecondary.copyWith(
          color: AppColors.secondaryText.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
