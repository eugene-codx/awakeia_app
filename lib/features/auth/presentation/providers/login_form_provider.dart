import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../shared/base/base_state_notifier.dart';
import '../../../../shared/validators/form_validators.dart';
import '../../domain/failures/auth_failure.dart';
import 'auth_providers.dart';

part 'login_form_provider.freezed.dart';

/// State for the login form
@freezed
abstract class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    @Default('') String emailUsername,
    @Default('') String password,
    @Default(true) bool isPasswordHidden,
    String? emailUsernameError,
    String? passwordError,
    @Default(false) bool isLoading,
    String? generalError,
  }) = _LoginFormState;
}

/// Provider for managing login form state
class LoginFormNotifier extends BaseStateNotifier<LoginFormState>
    with FormValidationMixin<LoginFormState> {
  @override
  LoginFormState build() {
    AppLogger.info('LoginFormNotifier.build: Initializing');
    return const LoginFormState();
  }

  /// Update emailUsername field
  void updateEmailUsername(String emailUsername) {
    logAction('LoginFormNotifier.updateEmailUsername: Updating emailUsername');

    state = state.copyWith(
      emailUsername: emailUsername,
      emailUsernameError: null,
      generalError: null,
    );

    // Delayed validation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.emailUsername == emailUsername) {
        if (emailUsername.contains('@')) {
          _validateEmail();
        } else {
          _validateUsername();
        }
      }
    });
  }

  /// Update password field
  void updatePassword(String password) {
    logAction('LoginFormNotifier.updatePassword: Updating password');

    state = state.copyWith(
      password: password,
      passwordError: null,
      generalError: null,
    );

    // Delayed validation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.password == password) {
        _validatePassword();
      }
    });
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    logAction(
      'LoginFormNotifier.togglePasswordVisibility: Toggling visibility',
    );
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  /// Submit login form
  Future<void> signIn() async {
    logAction('LoginFormNotifier.signIn: Sign in requested');

    // Clear previous errors
    state = state.copyWith(generalError: null);

    // Validate form
    if (!_validateForm()) {
      logError('LoginFormNotifier.signIn: Form validation failed');
      return;
    }

    // Set loading state
    state = state.copyWith(isLoading: true);

    try {
      // Call auth notifier directly instead of using action provider
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.signIn(state.emailUsername.trim(), state.password);

      logAction('LoginFormNotifier.signIn: Sign in successful');

      // Проверяем результат аутентификации
      final authState = ref.read(authNotifierProvider);

      // Ждем пока состояние обновится
      await authState.when(
        data: (authStateData) async {
          if (authStateData.isAuthenticated) {
            logAction('LoginFormNotifier.signIn: Sign in successful');
            // Reset form on success
            state = const LoginFormState();
          } else {
            // Обрабатываем ошибку аутентификации
            final failure = authStateData.errorMessage;
            String errorMessage = 'Invalid email or password';

            if (failure != null) {
              errorMessage = failure;
            }

            logError(
                'LoginFormNotifier.signIn: Authentication failed', failure);

            state = state.copyWith(
              isLoading: false,
              generalError: errorMessage,
            );
          }
        },
        loading: () {
          // Состояние еще загружается, ждем
        },
        error: (error, _) {
          logError('LoginFormNotifier.signIn: Sign in error', error);

          String errorMessage = 'An error occurred during sign in';
          if (error is AuthFailure) {
            errorMessage = error.toMessage();
          }

          state = state.copyWith(
            isLoading: false,
            generalError: errorMessage,
          );
        },
      );
    } catch (error) {
      logError('LoginFormNotifier.signIn: Sign in failed', error);

      // Handle error
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

  /// Clear general error
  void clearError() {
    if (state.generalError != null) {
      logAction('LoginFormNotifier.clearError: Clearing general error');
      state = state.copyWith(generalError: null);
    }
  }

  /// Reset form to initial state
  void resetForm() {
    logAction('LoginFormNotifier.resetForm: Resetting form');
    state = const LoginFormState();
  }

  // Private validation methods

  bool _validateForm() {
    logAction('LoginFormNotifier._validateForm: Validating form');
    if (state.emailUsername.contains('@')) {
      _validateEmail();
    } else {
      _validateUsername();
    }
    _validatePassword();

    return state.emailUsernameError == null && state.passwordError == null;
  }

  void _validateEmail() {
    logAction('LoginFormNotifier._validateEmail: Validating email');
    final error = AuthFormValidators.validateEmail(state.emailUsername);
    if (state.emailUsernameError != error) {
      state = state.copyWith(emailUsernameError: error);
    }
  }

  void _validateUsername() {
    logAction('LoginFormNotifier._validateUsername: Validating username');
    final error = AuthFormValidators.validateUsername(state.emailUsername);
    if (state.emailUsernameError != error) {
      state = state.copyWith(emailUsernameError: error);
    }
  }

  void _validatePassword() {
    logAction('LoginFormNotifier._validatePassword: Validating password');
    final error = AuthFormValidators.validatePassword(state.password);
    if (state.passwordError != error) {
      state = state.copyWith(passwordError: error);
    }
  }
}

/// Main provider for login form
final loginFormProvider =
    AutoDisposeNotifierProvider<LoginFormNotifier, LoginFormState>(
  LoginFormNotifier.new,
);
