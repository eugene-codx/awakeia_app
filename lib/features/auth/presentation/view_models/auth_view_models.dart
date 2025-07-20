import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../shared/base/base_view_model.dart';
import '../providers/auth_providers.dart';

/// View Model для экрана входа
class LoginViewModel extends BaseViewModel with FormValidationMixin {
  LoginViewModel(this._ref);

  final Ref _ref;

  @override
  void dispose() {
    AppLogger.debug('LoginViewModel disposed');
    super.dispose();
  }

  /// Выполнить вход
  Future<void> signIn(String email, String password) async {
    AppLogger.debug('Sign in requested for email: $email');

    if (!_validateLoginForm(email, password)) {
      return;
    }

    await executeWithLoading(() async {
      final signInAction = _ref.read(signInActionProvider);
      await signInAction(email, password);
    });
  }

  /// Валидация формы входа
  bool _validateLoginForm(String email, String password) {
    return validateForm({
      'email': () => _validateEmail(email),
      'password': () => _validatePassword(password),
    });
  }

  /// Валидация email
  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Валидация пароля
  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter your password';
    }
    if (password.length < 6) {
      return 'Password must contain at least 6 characters';
    }
    return null;
  }

  /// Получить ошибку валидации для email
  String? get emailError => getValidationError('email');

  /// Получить ошибку валидации для пароля
  String? get passwordError => getValidationError('password');
}

/// View Model для экрана регистрации
class RegisterViewModel extends BaseViewModel with FormValidationMixin {
  RegisterViewModel(this._ref);

  final Ref _ref;

  @override
  void dispose() {
    AppLogger.debug('RegisterViewModel disposed');
    super.dispose();
  }

  /// Выполнить регистрацию
  Future<void> register(
      String email, String password, String confirmPassword,) async {
    AppLogger.debug('Registration requested for email: $email');

    if (!_validateRegisterForm(email, password, confirmPassword)) {
      return;
    }

    await executeWithLoading(() async {
      final registerAction = _ref.read(registerActionProvider);
      await registerAction(email, password);
    });
  }

  /// Валидация формы регистрации
  bool _validateRegisterForm(
      String email, String password, String confirmPassword,) {
    return validateForm({
      'email': () => _validateEmail(email),
      'password': () => _validatePassword(password),
      'confirmPassword': () =>
          _validateConfirmPassword(password, confirmPassword),
    });
  }

  /// Валидация email
  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Валидация пароля
  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter your password';
    }
    if (password.length < 6) {
      return 'Password must contain at least 6 characters';
    }
    return null;
  }

  /// Валидация подтверждения пароля
  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Получить ошибку валидации для email
  String? get emailError => getValidationError('email');

  /// Получить ошибку валидации для пароля
  String? get passwordError => getValidationError('password');

  /// Получить ошибку валидации для подтверждения пароля
  String? get confirmPasswordError => getValidationError('confirmPassword');
}

/// View Model для экрана загрузки аутентификации
class AuthLoadingViewModel extends BaseViewModel {
  AuthLoadingViewModel(this._ref) {
    _init();
  }

  final Ref _ref;

  @override
  void dispose() {
    AppLogger.debug('AuthLoadingViewModel disposed');
    super.dispose();
  }

  /// Инициализация
  void _init() {
    AppLogger.debug('AuthLoadingViewModel initialized');

    // Слушаем изменения состояния аутентификации
    _ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          AppLogger.debug('Auth state changed in AuthLoadingViewModel');
          // Навигация будет обработана в UI
        },
        error: (error, stackTrace) {
          AppLogger.error(
              'Auth error in AuthLoadingViewModel', error, stackTrace,);
          setError(error.toString());
        },
      );
    });
  }

  /// Проверить состояние аутентификации
  bool get isAuthenticated {
    return _ref.read(isAuthenticatedProvider);
  }

  /// Проверить, идет ли загрузка
  bool get isAuthLoading {
    return _ref.read(isAuthLoadingProvider);
  }
}

/// Провайдеры для auth view models
final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
  return LoginViewModel(ref);
});

final registerViewModelProvider =
    ChangeNotifierProvider<RegisterViewModel>((ref) {
  return RegisterViewModel(ref);
});

final authLoadingViewModelProvider =
    ChangeNotifierProvider<AuthLoadingViewModel>((ref) {
  return AuthLoadingViewModel(ref);
});

// Convenience providers для доступа к состоянию view models

/// Провайдеры для LoginViewModel
final loginLoadingProvider = Provider<bool>((ref) {
  return ref.watch(loginViewModelProvider).isLoading;
});

final loginErrorProvider = Provider<String?>((ref) {
  return ref.watch(loginViewModelProvider).error;
});

final loginEmailErrorProvider = Provider<String?>((ref) {
  return ref.watch(loginViewModelProvider).emailError;
});

final loginPasswordErrorProvider = Provider<String?>((ref) {
  return ref.watch(loginViewModelProvider).passwordError;
});

/// Провайдеры для RegisterViewModel
final registerLoadingProvider = Provider<bool>((ref) {
  return ref.watch(registerViewModelProvider).isLoading;
});

final registerErrorProvider = Provider<String?>((ref) {
  return ref.watch(registerViewModelProvider).error;
});

final registerEmailErrorProvider = Provider<String?>((ref) {
  return ref.watch(registerViewModelProvider).emailError;
});

final registerPasswordErrorProvider = Provider<String?>((ref) {
  return ref.watch(registerViewModelProvider).passwordError;
});

final registerConfirmPasswordErrorProvider = Provider<String?>((ref) {
  return ref.watch(registerViewModelProvider).confirmPasswordError;
});

/// Провайдеры для AuthLoadingViewModel
final authLoadingLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authLoadingViewModelProvider).isLoading;
});

final authLoadingErrorProvider = Provider<String?>((ref) {
  return ref.watch(authLoadingViewModelProvider).error;
});

// Action providers

/// Действия для LoginViewModel
final loginSignInActionProvider = Provider((ref) {
  return (String email, String password) async {
    await ref.read(loginViewModelProvider).signIn(email, password);
  };
});

final clearLoginErrorActionProvider = Provider((ref) {
  return () {
    ref.read(loginViewModelProvider).clearError();
  };
});

final clearLoginValidationErrorsActionProvider = Provider((ref) {
  return () {
    ref.read(loginViewModelProvider).clearValidationErrors();
  };
});

/// Действия для RegisterViewModel
final registerSignUpActionProvider = Provider((ref) {
  return (String email, String password, String confirmPassword) async {
    await ref
        .read(registerViewModelProvider)
        .register(email, password, confirmPassword);
  };
});

final clearRegisterErrorActionProvider = Provider((ref) {
  return () {
    ref.read(registerViewModelProvider).clearError();
  };
});

final clearRegisterValidationErrorsActionProvider = Provider((ref) {
  return () {
    ref.read(registerViewModelProvider).clearValidationErrors();
  };
});
