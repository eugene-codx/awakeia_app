import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

/// Notifier for managing authentication state
/// Uses AsyncNotifier for better async operation handling
class AuthNotifier extends AsyncNotifier<AuthState> {
  late final AuthRepository _repository;
  late final LoginUseCase _loginUseCase;
  late final RegisterUseCase _registerUseCase;
  late final Talker _talker;

  StreamSubscription<UserEntity?>? _authStateSubscription;

  @override
  Future<AuthState> build() async {
    // Get dependencies from ref
    _repository = ref.watch(authRepositoryProvider);
    _loginUseCase = ref.watch(loginUseCaseProvider);
    _registerUseCase = ref.watch(registerUseCaseProvider);
    _talker = ref.watch(talkerProvider);

    // Listen to auth state changes
    _authStateSubscription?.cancel();
    _authStateSubscription = _repository.authStateChanges.listen((user) {
      if (user != null) {
        state = AsyncData(AuthState.authenticated(user));
      } else {
        state = const AsyncData(AuthState.unauthenticated());
      }
    });

    // Clean up subscription when notifier is disposed
    ref.onDispose(() {
      _authStateSubscription?.cancel();
    });

    // Check initial auth status
    return await _checkAuthStatus();
  }

  /// Check current authentication status
  Future<AuthState> _checkAuthStatus() async {
    _talker.info('Checking authentication status');

    final result = await _repository.getCurrentUser();

    return result.fold(
      (failure) {
        _talker.error('Failed to get current user: ${failure.toMessage()}');
        return AuthState.unauthenticated(failure);
      },
      (user) {
        if (user != null) {
          _talker.info('User authenticated: ${user.id}');
          return AuthState.authenticated(user);
        } else {
          _talker.info('User not authenticated');
          return const AuthState.unauthenticated();
        }
      },
    );
  }

  /// Sign in with email and password
  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();

    final params = LoginParams(email: email, password: password);
    final result = await _loginUseCase.call(params);

    result.fold(
      (failure) {
        _talker.error('Login failed: ${failure.toMessage()}');
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        _talker.info('Login successful: ${user.id}');
        state = AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Register with email and password
  Future<void> register(String email, String password) async {
    state = const AsyncLoading();

    final params = RegisterParams(email: email, password: password);
    final result = await _registerUseCase.call(params);

    result.fold(
      (failure) {
        _talker.error('Registration failed: ${failure.toMessage()}');
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        _talker.info('Registration successful: ${user.id}');
        state = AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Sign in as guest
  Future<void> signInAsGuest() async {
    state = const AsyncLoading();

    final result = await _repository.signInAsGuest();

    result.fold(
      (failure) {
        _talker.error('Guest sign in failed: ${failure.toMessage()}');
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        _talker.info('Guest sign in successful: ${user.id}');
        state = AsyncData(AuthState.authenticated(user));
      },
    );
  }

  /// Sign out current user
  Future<void> signOut() async {
    state = const AsyncLoading();

    final result = await _repository.signOut();

    result.fold(
      (failure) {
        _talker.error('Sign out failed: ${failure.toMessage()}');
        // Even if sign out fails, we should unauthenticate locally
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (_) {
        _talker.info('Sign out successful');
        state = const AsyncData(AuthState.unauthenticated());
      },
    );
  }

  /// Update user profile
  Future<void> updateProfile({String? name}) async {
    final currentUser = state.valueOrNull?.user;
    if (currentUser == null) {
      _talker.error('Cannot update profile: no authenticated user');
      return;
    }

    state = const AsyncLoading();

    final result = await _repository.updateUserProfile(
      userId: currentUser.id,
      name: name,
    );

    result.fold(
      (failure) {
        _talker.error('Profile update failed: ${failure.toMessage()}');
        // Restore previous state with error
        state = AsyncData(AuthState.authenticated(currentUser));
      },
      (updatedUser) {
        _talker.info('Profile updated successfully');
        state = AsyncData(AuthState.authenticated(updatedUser));
      },
    );
  }
}

// Placeholder providers - will be defined in next step
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  throw UnimplementedError('authRepositoryProvider not implemented');
});

// Providers are imported from auth_providers.dart
