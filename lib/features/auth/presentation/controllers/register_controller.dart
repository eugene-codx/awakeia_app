import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/base/base_state_notifier.dart';
import '../../domain/failures/auth_failure.dart';
import '../providers/auth_providers.dart';

part 'register_controller.freezed.dart';

/// Состояние экрана регистрации
@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(true) bool isPasswordHidden,
    @Default(true) bool isConfirmPasswordHidden,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    @Default(false) bool isLoading,
    String? generalError,
    @Default(false) bool agreedToTerms,
  }) = _RegisterState;
}

/// Контроллер для экрана регистрации (замена RegisterViewModel)
class RegisterController extends BaseStateNotifier<RegisterState>
    with FormValidationMixin<RegisterState> {
  @override
  RegisterState build() {
    // Начальное состояние
    return const RegisterState();
  }

  /// Обновить email
  void updateEmail(String email) {
    logAction('Updating email');

    state = state.copyWith(
      email: email,
      emailError: null,
      generalError: null,
    );

    // Отложенная валидация
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.email == email) {
        _validateEmail();
      }
    });
  }

  /// Обновить пароль
  void updatePassword(String password) {
    logAction('Updating password');

    state = state.copyWith(
      password: password,
      passwordError: null,
      generalError: null,
    );

    // Отложенная валидация
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.password == password) {
        _validatePassword();
        // Также проверяем подтверждение пароля если оно заполнено
        if (state.confirmPassword.isNotEmpty) {
          _validateConfirmPassword();
        }
      }
    });
  }

  /// Обновить подтверждение пароля
  void updateConfirmPassword(String confirmPassword) {
    logAction('Updating confirm password');

    state = state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordError: null,
      generalError: null,
    );

    // Отложенная валидация
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.confirmPassword == confirmPassword) {
        _validateConfirmPassword();
      }
    });
  }

  /// Переключить видимость пароля
  void togglePasswordVisibility() {
    logAction('Toggling password visibility');
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  /// Переключить видимость подтверждения пароля
  void toggleConfirmPasswordVisibility() {
    logAction('Toggling confirm password visibility');
    state = state.copyWith(
      isConfirmPasswordHidden: !state.isConfirmPasswordHidden,
    );
  }

  /// Переключить согласие с условиями
  void toggleTermsAgreement() {
    logAction('Toggling terms agreement');
    state = state.copyWith(
      agreedToTerms: !state.agreedToTerms,
      generalError: null,
    );
  }

  /// Выполнить регистрацию
  Future<void> register() async {
    logAction('Registration requested');

    // Очищаем предыдущие ошибки
    state = state.copyWith(generalError: null);

    // Проверяем согласие с условиями
    if (!state.agreedToTerms) {
      state = state.copyWith(
        generalError: 'Please agree to the terms and conditions',
      );
      return;
    }

    // Валидируем форму
    if (!_validateForm()) {
      logAction('Form validation failed');
      return;
    }

    // Устанавливаем состояние загрузки
    state = state.copyWith(isLoading: true);

    try {
      // Вызываем action для регистрации
      final registerAction = ref.read(registerActionProvider);
      await registerAction(state.email.trim(), state.password);

      logAction('Registration successful');
      // Навигация будет обработана через слушатель authNotifierProvider
    } catch (error) {
      logError('Registration failed', error);

      // Обрабатываем ошибку
      String errorMessage = 'An error occurred during registration';

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
    final confirmPasswordError = _validateConfirmPasswordValue(
      state.password,
      state.confirmPassword,
    );

    state = state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );

    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;
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

  /// Валидация подтверждения пароля
  void _validateConfirmPassword() {
    final error = _validateConfirmPasswordValue(
      state.password,
      state.confirmPassword,
    );
    if (state.confirmPasswordError != error) {
      state = state.copyWith(confirmPasswordError: error);
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
    // Можно добавить дополнительные проверки:
    // - наличие цифр
    // - наличие заглавных букв
    // - наличие специальных символов
    return null;
  }

  /// Логика валидации подтверждения пароля
  String? _validateConfirmPasswordValue(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Сброс формы
  void resetForm() {
    logAction('Resetting form');
    state = const RegisterState();
  }
}

/// Провайдер для RegisterController
final registerControllerProvider =
    AutoDisposeNotifierProvider<RegisterController, RegisterState>(
  RegisterController.new,
);

// Convenience providers для доступа к отдельным частям состояния

/// Провайдер для состояния загрузки
final registerLoadingProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(registerControllerProvider).isLoading;
});

/// Провайдер для общей ошибки
final registerGeneralErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(registerControllerProvider).generalError;
});

/// Провайдер для ошибки email
final registerEmailErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(registerControllerProvider).emailError;
});

/// Провайдер для ошибки пароля
final registerPasswordErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(registerControllerProvider).passwordError;
});

/// Провайдер для ошибки подтверждения пароля
final registerConfirmPasswordErrorProvider =
    Provider.autoDispose<String?>((ref) {
  return ref.watch(registerControllerProvider).confirmPasswordError;
});
