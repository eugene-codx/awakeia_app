// THIS IS A COMPATIBILITY ADAPTER
// This file provides backward compatibility with the old auth system
// It will be removed when screens are migrated to the new architecture

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/auth.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../models/user.dart';

/// Legacy AuthNotifier for backward compatibility
/// This wraps the new auth system to work with old screens
class AuthNotifier extends StateNotifier<AuthStatus> {
  AuthNotifier(this._ref) : super(AuthStatus.initial()) {
    // Listen to new auth state and convert to old format
    _ref.listen(authNotifierProvider, (previous, next) {
      next.when(
        data: (authState) {
          authState.when(
            initial: () => state = AuthStatus.initial(),
            loading: () => state = AuthStatus.loading(),
            authenticated: (user) {
              // Convert new UserEntity to old User model
              final oldUser = User(
                id: user.id,
                email: user.email,
                name: user.name,
                createdAt: user.createdAt,
                isGuest: user.isGuest,
              );
              state = AuthStatus.authenticated(oldUser);
            },
            unauthenticated: (failure) {
              state = AuthStatus.unauthenticated(failure?.toMessage());
            },
          );
        },
        loading: () => state = AuthStatus.loading(),
        error: (error, _) =>
            state = AuthStatus.unauthenticated(error.toString()),
      );
    });
  }
  final Ref _ref;

  /// Login method - delegates to new system
  Future<void> login(String email, String password) async {
    state = AuthStatus.loading();
    final signIn = _ref.read(signInActionProvider);
    await signIn(email, password);
  }

  /// Register method - delegates to new system
  Future<void> register(String email, String password) async {
    state = AuthStatus.loading();
    final register = _ref.read(registerActionProvider);
    await register(email, password);
  }

  /// Login as guest - delegates to new system
  void loginAsGuest() {
    final signInAsGuest = _ref.read(signInAsGuestActionProvider);
    signInAsGuest();
  }

  /// Logout method - delegates to new system
  Future<void> logout() async {
    state = AuthStatus.loading();
    final signOut = _ref.read(signOutActionProvider);
    await signOut();
  }

  /// Update user profile - delegates to new system
  void updateUserProfile({String? name}) {
    final updateProfile = _ref.read(updateProfileActionProvider);
    updateProfile(name: name);
  }
}

/// Legacy auth provider for backward compatibility
final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(ref);
});

/// Legacy convenience providers
final currentUserProvider = Provider<User?>((ref) {
  final authStatus = ref.watch(authProvider);
  return authStatus.user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authStatus = ref.watch(authProvider);
  return authStatus.isAuthenticated;
});

final isAuthLoadingProvider = Provider<bool>((ref) {
  final authStatus = ref.watch(authProvider);
  return authStatus.isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  final authStatus = ref.watch(authProvider);
  return authStatus.error;
});
