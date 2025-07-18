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
  AuthRepository? _repository;
  LoginUseCase? _loginUseCase;
  RegisterUseCase? _registerUseCase;
  Talker? _talker;

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

  Talker get talker {
    _talker ??= ref.read(talkerProvider);
    return _talker!;
  }

  @override
  Future<AuthState> build() async {
    // Initialize dependencies
    _repository = ref.watch(authRepositoryProvider);
    _loginUseCase = ref.watch(loginUseCaseProvider);
    _registerUseCase = ref.watch(registerUseCaseProvider);
    _talker = ref.watch(talkerProvider);

    // Listen to auth state changes
    _authStateSubscription?.cancel();
    _authStateSubscription = repository.authStateChanges.listen((user) {
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
    talker.info('Checking authentication status');

    final result = await repository.getCurrentUser();

    return result.fold(
      (failure) {
        talker.error('Failed to get current user: ${failure.toMessage()}');
        return AuthState.unauthenticated(failure);
      },
      (user) {
        if (user != null) {
          talker.info('User authenticated: ${user.id}');
          return AuthState.authenticated(user);
        } else {
          talker.info('User not authenticated');
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
        talker.error('Login failed: ${failure.toMessage()}');
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        talker.info('Login successful: ${user.id}');
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
        talker.error('Registration failed: ${failure.toMessage()}');
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        talker.info('Registration successful: ${user.id}');
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
        talker.error('Guest sign in failed: ${failure.toMessage()}');
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (user) {
        talker.info('Guest sign in successful: ${user.id}');
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
        talker.error('Sign out failed: ${failure.toMessage()}');
        // Even if sign out fails, we should unauthenticate locally
        state = AsyncData(AuthState.unauthenticated(failure));
      },
      (_) {
        talker.info('Sign out successful');
        state = const AsyncData(AuthState.unauthenticated());
      },
    );
  }

  /// Update user profile
  Future<void> updateProfile({String? name}) async {
    final currentUser = state.valueOrNull?.user;
    if (currentUser == null) {
      talker.error('Cannot update profile: no authenticated user');
      return;
    }

    state = const AsyncLoading();

    final result = await repository.updateUserProfile(
      userId: currentUser.id,
      name: name,
    );

    result.fold(
      (failure) {
        talker.error('Profile update failed: ${failure.toMessage()}');
        // Restore previous state with error
        state = AsyncData(AuthState.authenticated(currentUser));
      },
      (updatedUser) {
        talker.info('Profile updated successfully');
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
