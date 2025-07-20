import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/onboarding_view_model.dart';

/// Провайдер для OnboardingViewModel
final onboardingViewModelProvider =
    ChangeNotifierProvider<OnboardingViewModel>((ref) {
  return OnboardingViewModel(ref);
});

/// Провайдер для состояния onboarding экрана
final onboardingStateProvider = Provider<OnboardingState?>((ref) {
  return ref.watch(onboardingViewModelProvider).state;
});

/// Провайдер для флага загрузки onboarding экрана
final onboardingLoadingProvider = Provider<bool>((ref) {
  return ref.watch(onboardingViewModelProvider).isLoading;
});

/// Провайдер для ошибки onboarding экрана
final onboardingErrorProvider = Provider<String?>((ref) {
  return ref.watch(onboardingViewModelProvider).error;
});

/// Провайдер для флага процесса входа как гость
final isSigningInAsGuestProvider = Provider<bool>((ref) {
  return ref.watch(onboardingStateProvider)?.isSigningInAsGuest ?? false;
});

/// Провайдер для отображения аутентифицированного состояния
final showAuthenticatedViewProvider = Provider<bool>((ref) {
  return ref.watch(onboardingStateProvider)?.showAuthenticatedView ?? false;
});

/// Провайдер для общего состояния загрузки
final onboardingOverallLoadingProvider = Provider<bool>((ref) {
  return ref.watch(onboardingViewModelProvider).isOverallLoading;
});

/// Провайдер для проверки аутентификации
final onboardingIsAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(onboardingViewModelProvider).isAuthenticated;
});

/// Провайдер для проверки гостевого пользователя
final onboardingIsGuestUserProvider = Provider<bool>((ref) {
  return ref.watch(onboardingViewModelProvider).isGuestUser;
});

/// Провайдер для текущего пользователя
final onboardingCurrentUserProvider = Provider((ref) {
  return ref.watch(onboardingViewModelProvider).currentUser;
});

// ===== Action Providers =====

/// Провайдер для действия входа как гость
final onboardingSignInAsGuestActionProvider = Provider((ref) {
  return () async {
    await ref.read(onboardingViewModelProvider).signInAsGuest();
  };
});

/// Провайдер для действия выхода из системы
final onboardingSignOutActionProvider = Provider((ref) {
  return () async {
    await ref.read(onboardingViewModelProvider).signOut();
  };
});

/// Провайдер для действия навигации к логину
final navigateToLoginActionProvider = Provider((ref) {
  return () {
    ref.read(onboardingViewModelProvider).navigateToLogin();
  };
});

/// Провайдер для действия навигации к регистрации
final navigateToRegisterActionProvider = Provider((ref) {
  return () {
    ref.read(onboardingViewModelProvider).navigateToRegister();
  };
});

/// Провайдер для действия навигации в приложение
final navigateToAppActionProvider = Provider((ref) {
  return () {
    ref.read(onboardingViewModelProvider).navigateToApp();
  };
});

/// Провайдер для получения приветственного сообщения
final welcomeMessageProvider = Provider<String>((ref) {
  final viewModel = ref.watch(onboardingViewModelProvider);
  final currentUser = viewModel.currentUser;
  return viewModel.getWelcomeMessage(currentUser);
});

/// Провайдер для очистки ошибок onboarding
final clearOnboardingErrorActionProvider = Provider((ref) {
  return () {
    ref.read(onboardingViewModelProvider).clearError();
  };
});
