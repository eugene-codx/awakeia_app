import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

/// Notifier for managing authentication state
/// Uses AsyncNotifier for better async operation handling
class AuthNotifier extends AsyncNotifier<AuthState> {
  AuthRepository? _repository;
  LoginUseCase? _loginUseCase;
  RegisterUseCase? _registerUseCase;
  StreamSubscription<UserEntity?>? _authStateSubscription;

  // Getters that ensure initialization
  AuthRepository get repository {
    _repository ??= ref.read(authRepositoryProvider);
    return _repository!;
  }

  LoginUseCase get loginUseCase {
    _loginUseCase ??= ref.read(loginUseCaseProvider);
    return _loginUseCase!;
  }

  RegisterUseCase get registerUseCase {
    _registerUseCase ??= ref.read(registerUseCaseProvider);
    return _registerUseCase!;
  }

  @override
  Future<AuthState> build() async {
    // Initialize dependencies
    _repository = ref.watch(authRepositoryProvider);
    _loginUseCase = ref.watch(loginUseCaseProvider);
    _registerUseCase = ref.watch(registerUseCaseProvider);

    AppLogger.info('AuthNotifier.build: Initializing');

    // Clean up subscription when notifier is disposed
    ref.onDispose(() {
      AppLogger.info('AuthNotifier.build: Disposing');
      _authStateSubscription?.cancel();
    });

    // Check initial auth status first
    final initialState = await _checkAuthStatus();

    // Then setup listener for future changes
    _authStateSubscription?.cancel();
    _authStateSubscription = repository.authStateChanges.listen((user) {
      AppLogger.info(
        'AuthNotifier.build: Auth state changed from stream - user: ${user?.publicId}',
      );

      if (user != null) {
        state = AsyncData(AuthState.authenticated(user));
      } else {
        state = const AsyncData(AuthState.unauthenticated());
      }
    });

    return initialState;
  }

  /// Check current authentication status
  Future<AuthState> _checkAuthStatus() async {
    AppLogger.info(
      'AuthNotifier._checkAuthStatus: Checking authentication status',
    );

    final result = await repository.getCurrentUser();

    return result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier._checkAuthStatus: Failed to get current user: ${failure.toMessage()}',
        );
        return AuthState.unauthenticated(failure);
      },
      (user) {
        if (user != null) {
          AppLogger.info(
            'AuthNotifier._checkAuthStatus: User authenticated: ${user.publicId}',
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

  /// Sign in with email and password
  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();

    final params = LoginParams(email: email, password: password);
    final result = await loginUseCase.call(params);

    result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.signIn: Login failed: ${failure.toMessage()}',
        );
        // Use AsyncError instead of changing auth state to unauthenticated
        // This prevents router from redirecting while still allowing error handling
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        AppLogger.info(
            'AuthNotifier.signIn: Login successful: ${user.publicId}',);
        state = AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Register with email and password
  Future<void> register(String email, String password) async {
    state = const AsyncLoading();

    final params = RegisterParams(email: email, password: password);
    final result = await registerUseCase.call(params);

    result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.register: Registration failed: ${failure.toMessage()}',
        );
        // Use AsyncError instead of changing auth state to unauthenticated
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        AppLogger.info(
          'AuthNotifier.register: Registration successful: ${user.publicId}',
        );
        state = AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Sign in as guest
  Future<void> signInAsGuest() async {
    state = const AsyncLoading();

    final result = await repository.signInAsGuest();

    result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.signInAsGuest: Guest sign in failed: ${failure.toMessage()}',
        );
        // Use AsyncError instead of changing auth state to unauthenticated
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        AppLogger.info(
          'AuthNotifier.signInAsGuest: Guest sign in successful: ${user.publicId}',
        );
        state = AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Sign out current user
  Future<void> signOut() async {
    state = const AsyncLoading();

    final result = await repository.signOut();

    result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.signOut: Sign out failed: ${failure.toMessage()}',
        );
        // Even if sign out fails, we should unauthenticate locally
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (_) {
        AppLogger.info('AuthNotifier.signOut: Sign out successful');
        state = const AsyncData(AuthState.unauthenticated());
      },
    );
  }

  /// Update user profile
  Future<void> updateProfile({String? name}) async {
    final currentUser = state.valueOrNull?.user;
    if (currentUser == null) {
      AppLogger.error(
        'AuthNotifier.updateProfile: Cannot update profile: no authenticated user',
      );
      return;
    }

    state = const AsyncLoading();

    final result = await repository.updateUserProfile(
      userId: currentUser.publicId,
      name: name,
    );

    result.fold(
      (failure) {
        AppLogger.error(
          'AuthNotifier.updateProfile: Profile update failed: ${failure.toMessage()}',
        );
        // Restore previous state with error
        state = AsyncData(AuthState.authenticated(currentUser));
      },
      (updatedUser) {
        AppLogger.info(
          'AuthNotifier.updateProfile: Profile updated successfully',
        );
        state = AsyncData(AuthState.authenticated(updatedUser));
      },
    );
  }
}
