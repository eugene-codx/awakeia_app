import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

// ===== Core Dependencies =====

/// Provider for SecureStorage (shared across app)
final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage.instance;
});

// ===== Repository Provider =====

/// Main auth repository provider
/// Инкапсулирует создание всех data sources внутри
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);

  return AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceImpl(),
    localDataSource: AuthLocalDataSourceImpl(secureStorage: secureStorage),
  );
});

// ===== Main Auth State Provider =====

/// Главный провайдер состояния авторизации
/// Используйте этот провайдер для всех auth операций
final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

// ===== Convenience Providers =====

/// Провайдер текущего пользователя
/// Возвращает UserEntity? или null если не авторизован
final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.whenOrNull(
    data: (state) => state.user,
  );
});

/// Провайдер статуса авторизации
/// Возвращает true если пользователь авторизован
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.whenOrNull(
        data: (state) => state.isAuthenticated,
      ) ??
      false;
});

/// Провайдер loading состояния
/// Полезно для отображения loading индикаторов
final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
});

/// Провайдер ошибок авторизации
/// Возвращает последнюю ошибку или null
final authErrorProvider = Provider<AuthFailure?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.whenOrNull(
    data: (state) => state.whenOrNull(
      unauthenticated: (failure) => failure,
    ),
  );
});

/// Провайдер проверки гостевого пользователя
/// Возвращает true если текущий пользователь - гость
final isGuestUserProvider = Provider<bool>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  return currentUser?.isGuest ?? false;
});
