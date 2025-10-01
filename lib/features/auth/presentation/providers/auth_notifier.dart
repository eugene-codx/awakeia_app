import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

/// Notifier для управления состоянием авторизации

class AuthNotifier extends AsyncNotifier<AuthState> {
  late final AuthRepository _repository;
  StreamSubscription<UserEntity?>? _authStateSubscription;

  @override
  Future<AuthState> build() async {
    // Инициализация зависимостей
    _repository = ref.read(authRepositoryProvider);

    AppLogger.info('AuthNotifier: Initializing');

    // Cleanup при dispose
    ref.onDispose(() {
      AppLogger.info('AuthNotifier: Disposing');
      _authStateSubscription?.cancel();
    });

    // Проверяем начальный auth статус
    final initialState = await _checkAuthStatus();

    // Подписываемся на изменения auth state
    _setupAuthStateListener();

    return initialState;
  }

  // ===== Public Methods =====

  /// Вход с email и паролем
  Future<void> login({
    required String email,
    required String password,
  }) async {
    AppLogger.info('AuthNotifier.login: Attempting login for $email');

    state = const AsyncLoading();

    final result = await _repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    state = result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.login: Login failed - ${failure.toMessage()}',
        );
        return AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        AppLogger.info(
          'AuthNotifier.login: Login successful for ${user.publicId}',
        );
        return AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Регистрация нового пользователя
  Future<void> register({
    required String email,
    required String password,
    required String username,
    required String firstName,
  }) async {
    AppLogger.info('AuthNotifier.register: Attempting registration for $email');

    state = const AsyncLoading();

    final result = await _repository.registerWithEmailAndPassword(
      email: email,
      password: password,
      username: username,
      firstName: firstName,
    );

    state = result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.register: Registration failed - ${failure.toMessage()}',
        );
        return AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        AppLogger.info(
          'AuthNotifier.register: Registration successful for ${user.publicId}',
        );
        return AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Вход как гость
  Future<void> signInAsGuest() async {
    AppLogger.info('AuthNotifier.signInAsGuest: Attempting guest sign in');

    state = const AsyncLoading();

    final result = await _repository.signInAsGuest();

    state = result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.signInAsGuest: Failed - ${failure.toMessage()}',
        );
        return AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        AppLogger.info(
          'AuthNotifier.signInAsGuest: Success for ${user.publicId}',
        );
        return AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Выход из аккаунта
  Future<void> signOut() async {
    AppLogger.info('AuthNotifier.signOut: Attempting sign out');

    state = const AsyncLoading();

    final result = await _repository.signOut();

    state = result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.signOut: Failed - ${failure.toMessage()}',
        );
        return AsyncData(AuthState.unauthenticated(failure));
      },
      (_) {
        AppLogger.info('AuthNotifier.signOut: Sign out successful');
        return const AsyncData(AuthState.unauthenticated());
      },
    );
  }

  /// Обновление профиля пользователя
  Future<void> updateProfile({
    required String userId,
    String? name,
  }) async {
    AppLogger.info('AuthNotifier.updateProfile: Updating profile for $userId');

    state = const AsyncLoading();

    final result = await _repository.updateUserProfile(
      userId: userId,
      name: name,
    );

    state = result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.updateProfile: Failed - ${failure.toMessage()}',
        );
        return AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        AppLogger.info(
          'AuthNotifier.updateProfile: Profile updated for ${user.publicId}',
        );
        return AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Очистить ошибку
  void clearError() {
    state.whenData((currentState) {
      currentState.maybeWhen(
        unauthenticated: (failure) {
          if (failure != null) {
            // Если была ошибка, очищаем её
            state = const AsyncData(AuthState.unauthenticated());
          }
        },
        orElse: () {}, // Для других состояний ничего не делаем
      );
    });
  }

  // ===== Private Methods =====

  /// Проверка текущего auth статуса
  Future<AuthState> _checkAuthStatus() async {
    AppLogger.info('AuthNotifier._checkAuthStatus: Checking auth status');

    final result = await _repository.getCurrentUser();

    return result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier._checkAuthStatus: Failed - ${failure.toMessage()}',
        );
        return AuthState.unauthenticated(failure);
      },
      (user) {
        if (user != null) {
          AppLogger.info(
            'AuthNotifier._checkAuthStatus: User authenticated - ${user.publicId}',
          );
          return AuthState.authenticated(user);
        } else {
          AppLogger.info(
            'AuthNotifier._checkAuthStatus: User not authenticated',
          );
          return const AuthState.unauthenticated();
        }
      },
    );
  }

  /// Настройка слушателя изменений auth state
  void _setupAuthStateListener() {
    _authStateSubscription?.cancel();
    _authStateSubscription = _repository.authStateChanges.listen((user) {
      AppLogger.info(
        'AuthNotifier._setupAuthStateListener: Auth state changed - user: ${user?.publicId}',
      );

      state = AsyncData(
        user != null
            ? AuthState.authenticated(user)
            : const AuthState.unauthenticated(),
      );
    });
  }
}
