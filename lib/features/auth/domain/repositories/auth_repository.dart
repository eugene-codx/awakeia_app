import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../failures/auth_failure.dart';

/// Repository interface for authentication operations
/// This is a contract that must be implemented in the data layer
abstract class AuthRepository {
  /// Sign in with email and password
  /// Returns [UserEntity] on success or [AuthFailure] on failure
  Future<Either<AuthFailure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Register new user with email and password
  /// Returns [UserEntity] on success or [AuthFailure] on failure
  Future<Either<AuthFailure, UserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign in as guest user
  /// Returns [UserEntity] on success or [AuthFailure] on failure
  Future<Either<AuthFailure, UserEntity>> signInAsGuest();

  /// Sign out current user
  /// Returns [Unit] on success or [AuthFailure] on failure
  Future<Either<AuthFailure, Unit>> signOut();

  /// Get currently authenticated user
  /// Returns [UserEntity] if authenticated, null if not authenticated,
  /// or [AuthFailure] on error
  Future<Either<AuthFailure, UserEntity?>> getCurrentUser();

  /// Check if user is currently authenticated
  /// Returns true if authenticated, false otherwise
  Future<bool> isAuthenticated();

  /// Update user profile information
  /// Returns updated [UserEntity] on success or [AuthFailure] on failure
  Future<Either<AuthFailure, UserEntity>> updateUserProfile({
    required String userId,
    String? name,
  });

  /// Stream of authentication state changes
  /// Emits [UserEntity] when authenticated, null when not authenticated
  Stream<UserEntity?> get authStateChanges;
}
