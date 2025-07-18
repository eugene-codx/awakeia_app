import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:talker/talker.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../mappers/user_mapper.dart';
import '../models/user_model.dart';

/// Implementation of AuthRepository
/// Coordinates between remote and local data sources
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required Talker talker,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _talker = talker {
    // Initialize auth state
    _initializeAuthState();
  }
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final Talker _talker;

  // Stream controller for auth state changes
  final _authStateController = StreamController<UserEntity?>.broadcast();

  // Initialize auth state from local storage
  Future<void> _initializeAuthState() async {
    try {
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        _authStateController.add(UserMapper.toEntity(cachedUser));
      } else {
        _authStateController.add(null);
      }
    } catch (e) {
      _talker.error('Failed to initialize auth state', e);
      _authStateController.add(null);
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges => _authStateController.stream;

  @override
  Future<Either<AuthFailure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _talker.info('Attempting to sign in with email: $email');

      // Validate inputs locally first
      if (email.isEmpty || password.isEmpty) {
        return const Left(AuthFailure.invalidEmailAndPasswordCombination());
      }

      if (!_isValidEmail(email)) {
        return const Left(AuthFailure.invalidEmail());
      }

      if (password.length < 6) {
        return const Left(AuthFailure.weakPassword());
      }

      // Call remote data source
      final userModel = await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Cache user locally
      await _localDataSource.cacheUser(userModel);

      // Convert to entity
      final userEntity = UserMapper.toEntity(userModel);

      // Update auth state
      _authStateController.add(userEntity);

      _talker.info('Sign in successful for user: ${userEntity.id}');
      return Right(userEntity);
    } on ServerException catch (e) {
      _talker.error('Server error during sign in', e);
      return Left(AuthFailure.serverError(e.message));
    } on NetworkException {
      _talker.error('Network error during sign in');
      return const Left(AuthFailure.networkError());
    } catch (e) {
      _talker.error('Unexpected error during sign in', e);
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _talker.info('Attempting to register with email: $email');

      // Validate inputs locally first
      if (email.isEmpty || password.isEmpty) {
        return const Left(AuthFailure.invalidEmailAndPasswordCombination());
      }

      if (!_isValidEmail(email)) {
        return const Left(AuthFailure.invalidEmail());
      }

      if (password.length < 6) {
        return const Left(AuthFailure.weakPassword());
      }

      // Call remote data source
      final userModel = await _remoteDataSource.registerWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Cache user locally
      await _localDataSource.cacheUser(userModel);

      // Convert to entity
      final userEntity = UserMapper.toEntity(userModel);

      // Update auth state
      _authStateController.add(userEntity);

      _talker.info('Registration successful for user: ${userEntity.id}');
      return Right(userEntity);
    } on ServerException catch (e) {
      _talker.error('Server error during registration', e);

      // Handle specific registration errors
      if (e.message.contains('already exists')) {
        return const Left(AuthFailure.emailAlreadyInUse());
      }

      return Left(AuthFailure.serverError(e.message));
    } on NetworkException {
      _talker.error('Network error during registration');
      return const Left(AuthFailure.networkError());
    } catch (e) {
      _talker.error('Unexpected error during registration', e);
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signInAsGuest() async {
    try {
      _talker.info('Attempting to sign in as guest');

      // Create guest user
      final guestUser = UserModel(
        id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
        email: 'guest@awakeia.com',
        name: 'Guest User',
        createdAt: DateTime.now(),
        isGuest: true,
      );

      // Cache guest user locally
      await _localDataSource.cacheUser(guestUser);

      // Convert to entity
      final userEntity = UserMapper.toEntity(guestUser);

      // Update auth state
      _authStateController.add(userEntity);

      _talker.info('Guest sign in successful');
      return Right(userEntity);
    } catch (e) {
      _talker.error('Error during guest sign in', e);
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      _talker.info('Attempting to sign out');

      // Clear local cache first
      await _localDataSource.clearCachedUser();
      await _localDataSource.clearCachedAuthToken();

      // Then try to sign out from remote
      try {
        await _remoteDataSource.signOut();
      } catch (e) {
        // Log error but don't fail - user is already logged out locally
        _talker.warning('Failed to sign out from remote', e);
      }

      // Update auth state
      _authStateController.add(null);

      _talker.info('Sign out successful');
      return const Right(unit);
    } catch (e) {
      _talker.error('Error during sign out', e);
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity?>> getCurrentUser() async {
    try {
      _talker.info('Getting current user');

      // First check local cache
      final cachedUser = await _localDataSource.getCachedUser();

      if (cachedUser != null) {
        // If user is guest, return cached data
        if (cachedUser.isGuest) {
          _talker.info('Returning cached guest user');
          return Right(UserMapper.toEntity(cachedUser));
        }

        // For regular users, try to get fresh data from server
        try {
          final remoteUser = await _remoteDataSource.getCurrentUser();
          if (remoteUser != null) {
            // Update cache with fresh data
            await _localDataSource.cacheUser(remoteUser);
            return Right(UserMapper.toEntity(remoteUser));
          }
        } catch (e) {
          // If remote fails, return cached data
          _talker.warning('Failed to get user from remote, using cache', e);
          return Right(UserMapper.toEntity(cachedUser));
        }
      }

      // No cached user and no remote user
      _talker.info('No current user found');
      return const Right(null);
    } catch (e) {
      _talker.error('Error getting current user', e);
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final cachedUser = await _localDataSource.getCachedUser();
      return cachedUser != null;
    } catch (e) {
      _talker.error('Error checking authentication status', e);
      return false;
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> updateUserProfile({
    required String userId,
    String? name,
  }) async {
    try {
      _talker.info('Updating user profile for user: $userId');

      // Get current cached user
      final cachedUser = await _localDataSource.getCachedUser();

      if (cachedUser == null) {
        return const Left(AuthFailure.userNotFound());
      }

      // If guest user, update locally only
      if (cachedUser.isGuest) {
        final updatedUser = cachedUser.copyWith(name: name);
        await _localDataSource.cacheUser(updatedUser);

        final userEntity = UserMapper.toEntity(updatedUser);
        _authStateController.add(userEntity);

        return Right(userEntity);
      }

      // For regular users, update on server
      final updatedModel = await _remoteDataSource.updateUserProfile(
        userId: userId,
        name: name,
      );

      // Update local cache
      await _localDataSource.cacheUser(updatedModel);

      // Convert to entity
      final userEntity = UserMapper.toEntity(updatedModel);

      // Update auth state
      _authStateController.add(userEntity);

      _talker.info('Profile update successful');
      return Right(userEntity);
    } on ServerException catch (e) {
      _talker.error('Server error during profile update', e);
      return Left(AuthFailure.serverError(e.message));
    } on NetworkException {
      _talker.error('Network error during profile update');
      return const Left(AuthFailure.networkError());
    } catch (e) {
      _talker.error('Error updating profile', e);
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  // Helper method to validate email
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Dispose method to clean up resources
  void dispose() {
    _authStateController.close();
  }
}
