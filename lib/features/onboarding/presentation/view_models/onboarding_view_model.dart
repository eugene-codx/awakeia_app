import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../shared/base/base_view_model.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

/// Состояние экрана onboarding/welcome
class OnboardingState {
  const OnboardingState({
    this.isSigningInAsGuest = false,
    this.showAuthenticatedView = false,
  });

  final bool isSigningInAsGuest;
  final bool showAuthenticatedView;

  OnboardingState copyWith({
    bool? isSigningInAsGuest,
    bool? showAuthenticatedView,
  }) {
    return OnboardingState(
      isSigningInAsGuest: isSigningInAsGuest ?? this.isSigningInAsGuest,
      showAuthenticatedView:
          showAuthenticatedView ?? this.showAuthenticatedView,
    );
  }

  /// Проверить, идет ли процесс входа
  bool get isProcessing => isSigningInAsGuest;
}

/// View Model для экрана приветствия/onboarding
class OnboardingViewModel extends BaseViewModelWithState<OnboardingState> {
  OnboardingViewModel(this._ref) {
    _init();
  }

  final Ref _ref;

  @override
  void dispose() {
    AppLogger.debug('OnboardingViewModel disposed');
    super.dispose();
  }

  /// Инициализация view model
  void _init() {
    AppLogger.debug('OnboardingViewModel initialized');
    setState(const OnboardingState());

    // Слушаем изменения аутентификации
    _ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          _onAuthStateChanged(authState);
        },
      );
    });

    // Проверяем начальное состояние аутентификации
    _checkInitialAuthState();
  }

  /// Проверка начального состояния аутентификации
  void _checkInitialAuthState() {
    final authState = _ref.read(authNotifierProvider);
    authState.whenOrNull(
      data: (state) {
        final isAuthenticated = state.isAuthenticated;
        setState(state.copyWith(showAuthenticatedView: isAuthenticated));
      },
    );
  }

  /// Обработка изменения состояния аутентификации
  void _onAuthStateChanged(authState) {
    AppLogger.debug('Auth state changed in OnboardingViewModel');

    authState.when(
      initial: () {
        setState(state?.copyWith(showAuthenticatedView: false));
      },
      loading: () {
        // Состояние loading обрабатывается отдельно
      },
      authenticated: (user) {
        setState(state?.copyWith(
          showAuthenticatedView: true,
          isSigningInAsGuest: false,
        ),);
        AppLogger.debug('User authenticated: ${user.id}');
      },
      unauthenticated: (failure) {
        setState(state?.copyWith(
          showAuthenticatedView: false,
          isSigningInAsGuest: false,
        ),);
        if (failure != null) {
          setError(failure.toMessage());
        }
      },
    );
  }

  /// Enter guest mode
  Future<void> signInAsGuest() async {
    if (state?.isSigningInAsGuest == true) return;

    AppLogger.debug('Guest sign in requested');

    setState(state?.copyWith(isSigningInAsGuest: true));
    clearError();

    try {
      final signInAsGuest = _ref.read(signInAsGuestActionProvider);
      await signInAsGuest();
    } catch (e, stackTrace) {
      AppLogger.error('Guest sign in failed', e, stackTrace);
      setError('Failed to sign in as guest: $e');
    } finally {
      setState(state?.copyWith(isSigningInAsGuest: false));
    }
  }

  /// Quit from system
  Future<void> signOut() async {
    AppLogger.debug('Sign out requested from OnboardingViewModel');

    await executeWithLoading(() async {
      final signOut = _ref.read(signOutActionProvider);
      await signOut();
    });
  }

  /// Переход к экрану входа
  void navigateToLogin() {
    AppLogger.debug('Navigation to login requested');
    // Навигация будет обработана в UI
  }

  /// Переход к экрану регистрации
  void navigateToRegister() {
    AppLogger.debug('Navigation to register requested');
    // Навигация будет обработана в UI
  }

  /// Переход в приложение
  void navigateToApp() {
    AppLogger.debug('Navigation to app requested');
    // Навигация будет обработана в UI
  }

  /// Получить приветственное сообщение для аутентифицированного пользователя
  String getWelcomeMessage(UserEntity? user) {
    if (user == null) return 'Welcome!';

    if (user.isGuest) {
      return 'Welcome, Guest! 👋';
    } else {
      return 'Welcome, ${user.displayName}! 👋';
    }
  }

  /// Проверить, является ли пользователь гостем
  bool get isGuestUser {
    final currentUser = _ref.read(currentUserProvider);
    return currentUser?.isGuest ?? false;
  }

  /// Получить текущего пользователя
  UserEntity? get currentUser => _ref.read(currentUserProvider);

  /// Проверить, аутентифицирован ли пользователь
  bool get isAuthenticated {
    return _ref.read(isAuthenticatedProvider);
  }

  /// Проверить, идет ли загрузка аутентификации
  bool get isAuthLoading {
    return _ref.read(isAuthLoadingProvider);
  }

  /// Получить общее состояние loading
  bool get isOverallLoading {
    return isLoading || isAuthLoading || (state?.isProcessing ?? false);
  }
}
