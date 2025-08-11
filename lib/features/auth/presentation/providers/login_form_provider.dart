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
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool isPasswordHidden,
    String? emailError,
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

  /// Update email field
  void updateEmail(String email) {
    logAction('LoginFormNotifier.updateEmail: Updating email');

    state = state.copyWith(
      email: email,
      emailError: null,
      generalError: null,
    );

    // Delayed validation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.email == email) {
        _validateEmail();
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
        'LoginFormNotifier.togglePasswordVisibility: Toggling visibility',);
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  /// Submit login form
  Future<void> signIn() async {
    logAction('LoginFormNotifier.signIn: Sign in requested');

    // Clear previous errors
    state = state.copyWith(generalError: null);

    // Validate form
    if (!_validateForm()) {
      logAction('LoginFormNotifier.signIn: Form validation failed');
      return;
    }

    // Set loading state
    state = state.copyWith(isLoading: true);

    try {
      // Call auth notifier directly instead of using action provider
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.signIn(state.email.trim(), state.password);

      logAction('LoginFormNotifier.signIn: Sign in successful');

      // Reset form on success
      state = const LoginFormState();
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
    final emailError = AuthFormValidators.validateEmail(state.email);
    final passwordError = AuthFormValidators.validatePassword(state.password);

    state = state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
    );

    return emailError == null && passwordError == null;
  }

  void _validateEmail() {
    logAction('LoginFormNotifier._validateEmail: Validating email');
    final error = AuthFormValidators.validateEmail(state.email);
    if (state.emailError != error) {
      state = state.copyWith(emailError: error);
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

// Convenience providers for accessing specific parts of the state
//   Better to use the notifier directly for loading state
//   final isLoading = ref.watch(loginFormProvider.select((s) => s.isLoading));

// Provider for loading state
// final loginFormLoadingProvider = Provider.autoDispose<bool>((ref) {
//   return ref.watch(loginFormProvider).isLoading;
// });
//
// /// Provider for general error
// final loginFormErrorProvider = Provider.autoDispose<String?>((ref) {
//   return ref.watch(loginFormProvider).generalError;
// });
//
// /// Provider for email error
// final loginFormEmailErrorProvider = Provider.autoDispose<String?>((ref) {
//   return ref.watch(loginFormProvider).emailError;
// });
//
// /// Provider for password error
// final loginFormPasswordErrorProvider = Provider.autoDispose<String?>((ref) {
//   return ref.watch(loginFormProvider).passwordError;
// });
//
// /// Provider for password visibility
// final loginFormPasswordVisibilityProvider = Provider.autoDispose<bool>((ref) {
//   return ref.watch(loginFormProvider).isPasswordHidden;
// });
