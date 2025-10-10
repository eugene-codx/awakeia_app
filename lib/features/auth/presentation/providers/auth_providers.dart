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

// ===== Main Auth State Provider =====

/// Главный провайдер состояния авторизации
/// Используйте этот провайдер для всех auth операций
///
/// Для доступа к частям состояния используйте `.select()`:
///
/// ```dart
/// // Получить пользователя
/// final user = ref.watch(authProvider.select((s) => s.valueOrNull?.user));
///
/// // Проверить авторизацию
/// final isAuth = ref.watch(authProvider.select((s) =>
///   s.valueOrNull?.isAuthenticated ?? false
/// ));
///
/// // Проверить загрузку
/// final isLoading = ref.watch(authProvider.select((s) => s.isLoading));
///
/// // Получить ошибку
/// final error = ref.watch(authProvider.select((s) =>
///   s.valueOrNull?.errorMessage
/// ));
/// ```
