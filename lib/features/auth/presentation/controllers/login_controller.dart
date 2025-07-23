import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/base/base_state_notifier.dart';
import '../../domain/failures/auth_failure.dart';
import '../providers/auth_providers.dart';

part 'login_controller.freezed.dart';

/// Состояние экрана входа
@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool isPasswordHidden,
    String? emailError,
    String? passwordError,
    @Default(false) bool isLoading,
    String? generalError,
  }) = _LoginState;
}

/// Контроллер для экрана входа (замена LoginViewModel)
class LoginController extends BaseStateNotifier<LoginState>
    with FormValidationMixin<LoginState> {
  @override
  LoginState build() {
    // Начальное состояние
    return const LoginState();
  }

  /// Обновить email
  void updateEmail(String email) {
    logAction('Updating email');

    // Обновляем состояние
    state = state.copyWith(
      email: email,
      emailError: null, // Очищаем ошибку при изменении
      generalError: null,
    );

    // Валидируем после небольшой задержки (debounce эффект)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.email == email) {
        // Проверяем что значение не изменилось
        _validateEmail();
      }
    });
  }

  /// Обновить пароль
  void updatePassword(String password) {
    logAction('Updating password');

    state = state.copyWith(
      password: password,
      passwordError: null, // Очищаем ошибку при изменении
      generalError: null,
    );

    // Валидируем после небольшой задержки
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.password == password) {
        _validatePassword();
      }
    });
  }

  /// Переключить видимость пароля
  void togglePasswordVisibility() {
    logAction('Toggling password visibility');
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  /// Выполнить вход
  Future<void> signIn() async {
    logAction('Sign in requested');

    // Очищаем предыдущие ошибки
    state = state.copyWith(generalError: null);

    // Валидируем форму
    if (!_validateForm()) {
      logAction('Form validation failed');
      return;
    }

    // Устанавливаем состояние загрузки
    state = state.copyWith(isLoading: true);

    try {
      // Вызываем action для входа
      final signInAction = ref.read(signInActionProvider);
      await signInAction(state.email.trim(), state.password);

      logAction('Sign in successful');
      // Навигация будет обработана через слушатель authNotifierProvider
    } catch (error) {
      logError('Sign in failed', error);

      // Обрабатываем ошибку
      String errorMessage = 'An error occurred during sign in';

      if (error is AuthFailure) {
        errorMessage = error.toMessage();
      }

      state = state.copyWith(
        isLoading: false,
        generalError: errorMessage,
      );
    }
  }

  /// Очистить общую ошибку
  void clearError() {
    if (state.generalError != null) {
      state = state.copyWith(generalError: null);
    }
  }

  /// Валидация формы
  bool _validateForm() {
    final emailError = _validateEmailValue(state.email);
    final passwordError = _validatePasswordValue(state.password);

    state = state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
    );

    return emailError == null && passwordError == null;
  }

  /// Валидация email
  void _validateEmail() {
    final error = _validateEmailValue(state.email);
    if (state.emailError != error) {
      state = state.copyWith(emailError: error);
    }
  }

  /// Валидация пароля
  void _validatePassword() {
    final error = _validatePasswordValue(state.password);
    if (state.passwordError != error) {
      state = state.copyWith(passwordError: error);
    }
  }

  /// Логика валидации email
  String? _validateEmailValue(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Логика валидации пароля
  String? _validatePasswordValue(String password) {
    if (password.isEmpty) {
      return 'Please enter your password';
    }
    if (password.length < 6) {
      return 'Password must contain at least 6 characters';
    }
    return null;
  }

  /// Сброс формы
  void resetForm() {
    logAction('Resetting form');
    state = const LoginState();
  }
}

/// Провайдер для LoginController
final loginControllerProvider =
    AutoDisposeNotifierProvider<LoginController, LoginState>(
  LoginController.new,
);

// Convenience providers для доступа к отдельным частям состояния

/// Провайдер для состояния загрузки
final loginLoadingProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(loginControllerProvider).isLoading;
});

/// Провайдер для общей ошибки
final loginGeneralErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(loginControllerProvider).generalError;
});

/// Провайдер для ошибки email
final loginEmailErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(loginControllerProvider).emailError;
});

/// Провайдер для ошибки пароля
final loginPasswordErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(loginControllerProvider).passwordError;
});

/// Провайдер для видимости пароля
final loginPasswordVisibilityProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(loginControllerProvider).isPasswordHidden;
});
