import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/logging/app_logger.dart';
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
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource {
    // Initialize auth state
    _initializeAuthState();
  }

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  // Stream controller for auth state changes
  final _authStateController = StreamController<UserEntity?>.broadcast();

// Initialize auth state from local storage
  Future<void> _initializeAuthState() async {
    try {
      AppLogger.info(
        'AuthRepositoryImpl._initializeAuthState: Initializing auth state from local storage',
      );
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        AppLogger.info(
          'AuthRepositoryImpl._initializeAuthState: Found cached user: ${cachedUser.publicId}',
        );
        _authStateController.add(UserMapper.toEntity(cachedUser));
      } else {
        AppLogger.info(
          'AuthRepositoryImpl._initializeAuthState: No cached user found',
        );
        _authStateController.add(null);
      }
    } catch (e) {
      AppLogger.error(
        'AuthRepositoryImpl._initializeAuthState: Failed to initialize auth state',
        e,
      );
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
      AppLogger.info(
        'AuthRepositoryImpl.signInWithEmailAndPassword: Attempting to sign in with email: $email',
      );

      // Validate inputs locally first
      if (email.isEmpty || password.isEmpty) {
        return const Left(AuthFailure.invalidEmailAndPasswordCombination());
      }

      // Call remote data source
      await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userModel = await _remoteDataSource.getCurrentUser();

      // Cache user locally
      if (userModel != null) {
        await _localDataSource.cacheUser(userModel);
      } else {
        AppLogger.warning(
          'AuthRepositoryImpl.signInWithEmailAndPassword: No user data returned from remote',
        );
        return const Left(AuthFailure.userNotFound());
      }

      // Convert to entity
      final userEntity = UserMapper.toEntity(userModel);

      // Update auth state
      _authStateController.add(userEntity);

      AppLogger.info(
        'AuthRepositoryImpl.signInWithEmailAndPassword: Sign in successful for user: ${userEntity.publicId}',
      );
      return Right(userEntity);
    } on ServerException catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.signInWithEmailAndPassword: Server error during sign in',
        e,
        stackTrace,
      );
      return Left(AuthFailure.serverError(e.message));
    } on NetworkException catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.signInWithEmailAndPassword: Network error during sign in',
        e,
        stackTrace,
      );
      return const Left(AuthFailure.networkError());
    } catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.signInWithEmailAndPassword: Unexpected error during sign in',
        e,
        stackTrace,
      );
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.info(
        'AuthRepositoryImpl.registerWithEmailAndPassword: Attempting to register with email: $email',
      );

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

      AppLogger.info(
        'AuthRepositoryImpl.registerWithEmailAndPassword: Registration successful for user: ${userEntity.publicId}',
      );
      return Right(userEntity);
    } on ServerException catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.registerWithEmailAndPassword: Server error during registration',
        e,
        stackTrace,
      );

      // Handle specific registration errors
      if (e.message.contains('already exists')) {
        return const Left(AuthFailure.emailAlreadyInUse());
      }

      return Left(AuthFailure.serverError(e.message));
    } on NetworkException catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.registerWithEmailAndPassword: Network error during registration',
        e,
        stackTrace,
      );
      return const Left(AuthFailure.networkError());
    } catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.registerWithEmailAndPassword: Unexpected error during registration',
        e,
        stackTrace,
      );
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signInAsGuest() async {
    try {
      AppLogger.info(
        'AuthRepositoryImpl.signInAsGuest: Attempting to sign in as guest',
      );

      // Create guest user
      final guestUser = UserModel(
        publicId: const Uuid().v4(),
        email: 'guest@awakeia.com',
        username: 'guest_${DateTime.now().millisecondsSinceEpoch}',
        firstName: 'Guest User',
        isGuest: true,
      );

      // Cache guest user locally
      await _localDataSource.cacheUser(guestUser);

      // Convert to entity
      final userEntity = UserMapper.toEntity(guestUser);

      // Update auth state
      _authStateController.add(userEntity);

      AppLogger.info(
        'AuthRepositoryImpl.signInAsGuest: Guest sign in successful',
      );
      return Right(userEntity);
    } catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.signInAsGuest: Error during guest sign in',
        e,
        stackTrace,
      );
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      AppLogger.info('AuthRepositoryImpl.signOut: Attempting to sign out');

      // Clear local cache first
      await _localDataSource.clearCachedUser();
      await _localDataSource.clearCachedAuthToken();

      // Then try to sign out from remote
      try {
        await _remoteDataSource.signOut();
      } catch (e) {
        // Log error but don't fail - user is already logged out locally
        AppLogger.warning(
          'AuthRepositoryImpl.signOut: Failed to sign out from remote',
          e,
        );
      }

      // Update auth state
      _authStateController.add(null);

      AppLogger.info('AuthRepositoryImpl.signOut: Sign out successful');
      return const Right(unit);
    } catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.signOut: Error during sign out',
        e,
        stackTrace,
      );
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity?>> getCurrentUser() async {
    try {
      AppLogger.info('AuthRepositoryImpl.getCurrentUser: Getting current user');

      // First check local cache
      final cachedUser = await _localDataSource.getCachedUser();

      if (cachedUser != null) {
        // If user is guest, return cached data
        if (cachedUser.isGuest) {
          AppLogger.info(
            'AuthRepositoryImpl.getCurrentUser: Returning cached guest user',
          );
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
        } catch (e, stackTrace) {
          // If remote fails, return cached data
          AppLogger.warning(
            'AuthRepositoryImpl.getCurrentUser: Failed to get user from remote, using cache',
            e,
            stackTrace,
          );
          return Right(UserMapper.toEntity(cachedUser));
        }
      }

      // No cached user and no remote user
      AppLogger.info(
        'AuthRepositoryImpl.getCurrentUser: No current user found',
      );
      return const Right(null);
    } catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.getCurrentUser: Error getting current user',
        e,
        stackTrace,
      );
      return Left(AuthFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final cachedUser = await _localDataSource.getCachedUser();
      return cachedUser != null;
    } catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.isAuthenticated: Error checking authentication status',
        e,
        stackTrace,
      );
      return false;
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> updateUserProfile({
    required String userId,
    String? name,
  }) async {
    try {
      AppLogger.info(
        'AuthRepositoryImpl.updateUserProfile: Updating user profile for user: $userId',
      );

      // Get current cached user
      final cachedUser = await _localDataSource.getCachedUser();

      if (cachedUser == null) {
        return const Left(AuthFailure.userNotFound());
      }

      // If guest user, update locally only
      if (cachedUser.isGuest) {
        final updatedUser = cachedUser.copyWith(firstName: name);
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

      AppLogger.info(
        'AuthRepositoryImpl.updateUserProfile: Profile update successful',
      );
      return Right(userEntity);
    } on ServerException catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.updateUserProfile: Server error during profile update',
        e,
        stackTrace,
      );
      return Left(AuthFailure.serverError(e.message));
    } on NetworkException {
      AppLogger.error(
        'AuthRepositoryImpl.updateUserProfile: Network error during profile update',
      );
      return const Left(AuthFailure.networkError());
    } catch (e, stackTrace) {
      AppLogger.error(
        'AuthRepositoryImpl.updateUserProfile: Error updating profile',
        e,
        stackTrace,
      );
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
