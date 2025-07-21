import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

// ===== Data Sources Providers =====

/// Provider for auth remote data source
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl();
});

/// Provider for auth local data source
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthLocalDataSourceImpl(secureStorage: secureStorage);
});

// ===== Repository Provider =====

/// Provider for auth repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final talker = ref.watch(talkerProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    talker: talker,
  );
});

// ===== Use Cases Providers =====

/// Provider for login use case
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository: repository);
});

/// Provider for register use case
final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repository: repository);
});

// ===== Core Dependencies =====

/// Provider for Talker logger
final talkerProvider = Provider<Talker>((ref) {
  return AppLogger.instance.talker;
});

/// Provider for SecureStorage
final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage.instance;
});

// ===== App State Providers =====

/// Provider to check if this is the first launch of the app
final isFirstLaunchProvider = FutureProvider<bool>((ref) async {
  final secureStorage = ref.watch(secureStorageProvider);

  try {
    // Check if we have a flag indicating app has been launched before
    final hasLaunched = await secureStorage.read(key: 'has_launched');

    if (hasLaunched == null) {
      // First launch - set the flag
      await secureStorage.write(key: 'has_launched', value: 'true');
      return true;
    }

    return false;
  } catch (e) {
    // On error, assume not first launch
    AppLogger.error('Error checking first launch status', e);
    return false;
  }
});

// ===== Main Auth Provider =====

/// Main auth state provider using AsyncNotifier
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

// ===== Convenience Providers =====

/// Provider that returns only the current user
final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.whenOrNull(
    data: (state) => state.user,
  );
});

/// Provider that returns whether user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.whenOrNull(
        data: (state) => state.isAuthenticated,
      ) ??
      false;
});

/// Provider that returns whether authentication is loading
final isAuthLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.isLoading;
});

/// Provider that returns current authentication error message
final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.whenOrNull(
    data: (state) => state.errorMessage,
  );
});

/// Provider that returns whether current user is guest
final isGuestUserProvider = Provider<bool>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  return currentUser?.isGuest ?? false;
});

/// Stream provider for auth state changes
final authStateChangesProvider = StreamProvider<UserEntity?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
});

// ===== Actions Providers =====

/// Provider for sign in action
final signInActionProvider = Provider((ref) {
  return (String email, String password) async {
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signIn(email, password);
  };
});

/// Provider for register action
final registerActionProvider = Provider((ref) {
  return (String email, String password) async {
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.register(email, password);
  };
});

/// Provider for sign in as guest action
final signInAsGuestActionProvider = Provider((ref) {
  return () async {
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signInAsGuest();
  };
});

/// Provider for sign out action
final signOutActionProvider = Provider((ref) {
  return () async {
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signOut();
  };
});

/// Provider for update profile action
final updateProfileActionProvider = Provider((ref) {
  return ({String? name}) async {
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.updateProfile(name: name);
  };
});
