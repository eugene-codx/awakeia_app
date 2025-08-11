import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

/// Abstract class defining the contract for remote authentication operations
abstract class AuthRemoteDataSource {
  /// Sign in with email and password
  /// Throws [ServerException] on failure
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Register new user with email and password
  /// Throws [ServerException] on failure
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign out current user
  /// Throws [ServerException] on failure
  Future<void> signOut();

  /// Get current user from server
  /// Returns null if not authenticated
  /// Throws [ServerException] on failure
  Future<UserModel?> getCurrentUser();

  /// Update user profile
  /// Throws [ServerException] on failure
  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  });
}

/// Implementation of AuthRemoteDataSource
/// For now, this is a mock implementation that simulates API calls
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate API call delay
    await Future<void>.delayed(const Duration(seconds: 2));

    // Mock validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Return mock user
    return UserModel(
      id: const Uuid().v4(),
      email: email,
      username: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: email.split('@')[0],
      createdAt: DateTime.now(),
      isGuest: false,
    );
  }

  @override
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate API call delay
    await Future<void>.delayed(const Duration(seconds: 2));

    // Mock validation (same as login for now)
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Return mock user
    return UserModel(
      id: const Uuid().v4(),
      email: email,
      username: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: email.split('@')[0],
      createdAt: DateTime.now(),
      isGuest: false,
    );
  }

  @override
  Future<void> signOut() async {
    // Simulate API call delay
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // Simulate API call delay
    await Future<void>.delayed(const Duration(seconds: 1));

    // For now, always return null (not authenticated)
    return null;
  }

  @override
  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  }) async {
    // Simulate API call delay
    await Future<void>.delayed(const Duration(seconds: 1));

    // For mock, just return a user with updated name
    return UserModel(
      id: userId,
      email: 'mock_user@example.com',
      name: name,
      username: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      isGuest: false,
    );
  }
}
