import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

// AuthNotifier class that extends StateNotifier
// This class manages the authentication state of the application
class AuthNotifier extends StateNotifier<AuthStatus> {
  AuthNotifier() : super(AuthStatus.initial()) {
    // Check if user is already logged in when app starts
    _checkAuthStatus();
  }

  // Private method to check authentication status on app start
  Future<void> _checkAuthStatus() async {
    state = AuthStatus.loading();

    // Simulate checking stored authentication
    // In real app, this would check SharedPreferences, Secure Storage, etc.
    await Future<void>.delayed(const Duration(seconds: 1));

    // For now, assume user is not authenticated
    state = AuthStatus.unauthenticated();
  }

  // Login method
  Future<void> login(String email, String password) async {
    state = AuthStatus.loading();

    try {
      // Simulate API call delay
      await Future<void>.delayed(const Duration(seconds: 2));

      // Simple validation for demo purposes
      if (email.isEmpty || password.isEmpty) {
        state =
            AuthStatus.unauthenticated('Email and password cannot be empty');
        return;
      }

      if (!email.contains('@')) {
        state = AuthStatus.unauthenticated('Enter a valid email');
        return;
      }

      if (password.length < 6) {
        state = AuthStatus.unauthenticated(
          'Password must be at least 6 characters long',
        );
        return;
      }

      // Create user object (in real app, this would come from API)
      final user = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: email.split('@')[0], // Use part before @ as name
        createdAt: DateTime.now(),
      );

      state = AuthStatus.authenticated(user);
    } catch (e) {
      state = AuthStatus.unauthenticated('An error occurred during login: $e');
    }
  }

  // Register method
  Future<void> register(String email, String password) async {
    state = AuthStatus.loading();

    try {
      // Simulate API call delay
      await Future<void>.delayed(const Duration(seconds: 2));

      // Simple validation for demo purposes
      if (email.isEmpty || password.isEmpty) {
        state =
            AuthStatus.unauthenticated('Email and password cannot be empty');
        return;
      }

      if (!email.contains('@')) {
        state = AuthStatus.unauthenticated('Enter a valid email');
        return;
      }

      if (password.length < 6) {
        state = AuthStatus.unauthenticated(
          'Password must be at least 6 characters long',
        );
        return;
      }

      // Create new user object (in real app, this would come from API)
      final user = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: email.split('@')[0], // Use part before @ as name
        createdAt: DateTime.now(),
      );

      state = AuthStatus.authenticated(user);
    } catch (e) {
      state = AuthStatus.unauthenticated(
        'An error occurred during registration: $e',
      );
    }
  }

  // Login as guest method
  void loginAsGuest() {
    final guestUser = User.guest();
    state = AuthStatus.authenticated(guestUser);
  }

  // Logout method
  Future<void> logout() async {
    state = AuthStatus.loading();

    // Simulate logout process
    await Future<void>.delayed(const Duration(milliseconds: 500));

    state = AuthStatus.unauthenticated();
  }

  // Update user profile method
  void updateUserProfile({String? name}) {
    final currentUser = state.user;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(name: name);
      state = AuthStatus.authenticated(updatedUser);
    }
  }
}

// Provider for AuthNotifier
// This is the main provider that other parts of the app will use
final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier();
});

// Convenience providers for common use cases

// Provider that returns only the current user
final currentUserProvider = Provider<User?>((ref) {
  final authStatus = ref.watch(authProvider);
  return authStatus.user;
});

// Provider that returns whether user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authStatus = ref.watch(authProvider);
  return authStatus.isAuthenticated;
});

// Provider that returns whether authentication is loading
final isAuthLoadingProvider = Provider<bool>((ref) {
  final authStatus = ref.watch(authProvider);
  return authStatus.isLoading;
});

// Provider that returns current authentication error
final authErrorProvider = Provider<String?>((ref) {
  final authStatus = ref.watch(authProvider);
  return authStatus.error;
});
