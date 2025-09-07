import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../shared/base/base_state_notifier.dart';
import '../../../../shared/validators/form_validators.dart';
import '../../domain/failures/auth_failure.dart';
import 'auth_providers.dart';

part 'register_form_provider.freezed.dart';

/// State for the register form
@freezed
abstract class RegisterFormState with _$RegisterFormState {
  const factory RegisterFormState({
    @Default('') String username,
    @Default('') String firstName,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(true) bool isPasswordHidden,
    @Default(true) bool isConfirmPasswordHidden,
    String? usernameError,
    String? firstNameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    @Default(false) bool isLoading,
    String? generalError,
    @Default(false) bool agreedToTerms,
  }) = _RegisterFormState;
}

/// Provider for managing register form state
class RegisterFormNotifier extends BaseStateNotifier<RegisterFormState>
    with FormValidationMixin<RegisterFormState> {
  @override
  RegisterFormState build() {
    AppLogger.info('RegisterFormNotifier.build: Initializing');
    return const RegisterFormState();
  }

  /// Update username field
  void updateUsername(String username) {
    state = state.copyWith(
      username: username,
      usernameError: null,
      generalError: null,
    );

    // Delayed validation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.firstName == username) {
        _validateUsername();
      }
    });
  }

  /// Update first name field
  void updateFirstName(String firstName) {
    state = state.copyWith(
      firstName: firstName,
      firstNameError: null,
      generalError: null,
    );

    // Delayed validation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.firstName == firstName) {
        _validateFirstName();
      }
    });
  }

  /// Update email field
  void updateEmail(String email) {
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
    state = state.copyWith(
      password: password,
      passwordError: null,
      generalError: null,
    );

    // Delayed validation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.password == password) {
        _validatePassword();
        // Also validate confirm password if it's filled
        if (state.confirmPassword.isNotEmpty) {
          _validateConfirmPassword();
        }
      }
    });
  }

  /// Update confirm password field
  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordError: null,
      generalError: null,
    );

    // Delayed validation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.confirmPassword == confirmPassword) {
        _validateConfirmPassword();
      }
    });
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordHidden: !state.isConfirmPasswordHidden,
    );
  }

  /// Toggle terms agreement
  void toggleTermsAgreement() {
    state = state.copyWith(
      agreedToTerms: !state.agreedToTerms,
      generalError: null,
    );
  }

  /// Submit registration form
  Future<void> register() async {
    logAction('RegisterFormNotifier.register: Registration requested');

    // Clear previous errors
    state = state.copyWith(generalError: null);

    // Check terms agreement
    if (!state.agreedToTerms) {
      state = state.copyWith(
        generalError: 'Please agree to the terms and conditions',
      );
      return;
    }

    // Validate form
    if (!_validateForm()) {
      logError('RegisterFormNotifier.register: Form validation failed');
      return;
    }

    // Set loading state
    state = state.copyWith(isLoading: true);

    try {
      // Call auth notifier directly instead of using action provider
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.register(
        state.email.trim(),
        state.password,
        state.username.trim(),
        state.firstName.trim(),
      );

      final authAsync = ref.read(authNotifierProvider);

      authAsync.when(
        data: (authStateData) {
          if (authStateData.isAuthenticated) {
            logAction('RegisterFormNotifier.register: Sign in successful');
            // Reset form on success
            state = const RegisterFormState();
          } else {
            // This shouldn't happen with new logic, but keep as fallback
            logError('RegisterFormNotifier.register: Unexpected unauthenticated state');
            state = state.copyWith(
              isLoading: false,
              generalError: 'Unexpected authentication state',
            );
          }
        },
        loading: () {
          // Still loading - this shouldn't happen since signIn should complete
          logError('RegisterFormNotifier.register: Auth still loading after signIn completed');
          state = state.copyWith(
            isLoading: false,
            generalError: 'Authentication timeout',
          );
        },
        error: (error, _) {
          logError('RegisterFormNotifier.register: Register error', error);

          String errorMessage = 'Invalid email or password';
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
      logError('RegisterFormNotifier.register: Registration failed', error);

      // Handle error
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

  /// Clear general error
  void clearError() {
    if (state.generalError != null) {
      logAction('RegisterFormNotifier.clearError: Clearing general error');
      state = state.copyWith(generalError: null);
    }
  }

  /// Reset form to initial state
  void resetForm() {
    logAction('RegisterFormNotifier.resetForm: Resetting form');
    state = const RegisterFormState();
  }

  // Private validation methods
  bool _validateForm() {
    logAction('RegisterFormNotifier._validateForm: Validating form');
    final emailError = AuthFormValidators.validateEmail(state.email);
    final usernameError = AuthFormValidators.validateUsername(state.username);
    final firstNameError =
        AuthFormValidators.validateFirstName(state.firstName);
    final passwordError = AuthFormValidators.validatePassword(state.password);
    final confirmPasswordError = AuthFormValidators.validateConfirmPassword(
      state.password,
      state.confirmPassword,
    );

    state = state.copyWith(
      emailError: emailError,
      usernameError: usernameError,
      firstNameError: firstNameError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );

    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  void _validateUsername() {
    final error = AuthFormValidators.validateUsername(state.username);
    if (state.usernameError != error) {
      state = state.copyWith(usernameError: error);
    }
  }

  void _validateFirstName() {
    final error = AuthFormValidators.validateFirstName(state.firstName);
    if (state.firstNameError != error) {
      state = state.copyWith(firstNameError: error);
    }
  }

  void _validateEmail() {
    final error = AuthFormValidators.validateEmail(state.email);
    if (state.emailError != error) {
      state = state.copyWith(emailError: error);
    }
  }

  void _validatePassword() {
    final error = AuthFormValidators.validatePassword(state.password);
    if (state.passwordError != error) {
      state = state.copyWith(passwordError: error);
    }
  }

  void _validateConfirmPassword() {
    final error = AuthFormValidators.validateConfirmPassword(
      state.password,
      state.confirmPassword,
    );
    if (state.confirmPasswordError != error) {
      state = state.copyWith(confirmPasswordError: error);
    }
  }
}

/// Main provider for register form
final registerFormProvider =
    AutoDisposeNotifierProvider<RegisterFormNotifier, RegisterFormState>(
  RegisterFormNotifier.new,
);

// Convenience providers for accessing specific parts of the state

/// Provider for loading state
final registerFormLoadingProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(registerFormProvider).isLoading;
});

/// Provider for general error
final registerFormErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(registerFormProvider).generalError;
});

/// Provider for email error
final registerFormEmailErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(registerFormProvider).emailError;
});

/// Provider for password error
final registerFormPasswordErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(registerFormProvider).passwordError;
});

/// Provider for confirm password error
final registerFormConfirmPasswordErrorProvider =
    Provider.autoDispose<String?>((ref) {
  return ref.watch(registerFormProvider).confirmPasswordError;
});

/// Provider for terms agreement state
final registerFormTermsAgreedProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(registerFormProvider).agreedToTerms;
});

/// Provider for password visibility
final registerFormPasswordVisibilityProvider =
    Provider.autoDispose<bool>((ref) {
  return ref.watch(registerFormProvider).isPasswordHidden;
});

/// Provider for confirm password visibility
final registerFormConfirmPasswordVisibilityProvider =
    Provider.autoDispose<bool>((ref) {
  return ref.watch(registerFormProvider).isConfirmPasswordHidden;
});
