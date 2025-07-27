// lib/features/auth/presentation/controllers/auth_loading_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/base/base_state_notifier.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';

part 'auth_loading_controller.freezed.dart';

/// Состояние экрана загрузки аутентификации
@freezed
abstract class AuthLoadingState with _$AuthLoadingState {
  const factory AuthLoadingState({
    @Default(true) bool isCheckingAuth,
    String? error,
  }) = _AuthLoadingState;
}

/// Контроллер для экрана загрузки аутентификации
class AuthLoadingController extends BaseStateNotifier<AuthLoadingState> {
  @override
  AuthLoadingState build() {
    logAction('Initializing AuthLoadingController');

    // Начинаем проверку аутентификации сразу после инициализации
    listenSelf((previous, next) {
      // Слушаем собственные изменения для логирования
      if (next.error != null) {
        logError('Auth check error', next.error);
      }
    });

    // Слушаем изменения состояния аутентификации
    _setupAuthListener();

    return const AuthLoadingState();
  }

  /// Настройка слушателя аутентификации
  void _setupAuthListener() {
    // Слушаем изменения authNotifierProvider
    ref.listen(authNotifierProvider, (previous, next) {
      logAction('Auth state changed in loading screen');

      next.when(
        data: (authState) {
          logAction('Auth state data received: ${authState.runtimeType}');
          _handleAuthState(authState);
        },
        loading: () {
          logAction('Auth state is loading');
          // Продолжаем ждать
          state = state.copyWith(isCheckingAuth: true);
        },
        error: (error, stack) {
          logError('Auth state error', error, stack);
          // При ошибке считаем пользователя неаутентифицированным
          state = state.copyWith(
            isCheckingAuth: false,
            error: error.toString(),
          );
        },
      );
    });
  }

  /// Обработка состояния аутентификации
  void _handleAuthState(AuthState authState) {
    // Используем методы из AuthState для проверки
    if (authState.isInitial) {
      logAction('Auth state is initial, waiting...');
      state = state.copyWith(isCheckingAuth: true);
    } else if (authState.isLoading) {
      logAction('Auth state is loading, waiting...');
      state = state.copyWith(isCheckingAuth: true);
    } else if (authState.isAuthenticated) {
      logAction('User is authenticated');
      state = state.copyWith(isCheckingAuth: false);
    } else if (authState.isUnauthenticated) {
      logAction('User is not authenticated');
      state = state.copyWith(isCheckingAuth: false);
    }
  }

  /// Проверить состояние аутентификации вручную
  void checkAuthStatus() {
    logAction('Manual auth check requested');

    final authAsyncValue = ref.read(authNotifierProvider);

    authAsyncValue.when(
      data: (authState) => _handleAuthState(authState),
      loading: () {
        logAction('Auth still loading during manual check');
        state = state.copyWith(isCheckingAuth: true);
      },
      error: (error, stack) {
        logError('Error during manual auth check', error, stack);
        state = state.copyWith(
          isCheckingAuth: false,
          error: error.toString(),
        );
      },
    );
  }

  /// Сброс состояния (для тестирования)
  void reset() {
    logAction('Resetting state');
    state = const AuthLoadingState();
  }
}

/// Провайдер для AuthLoadingController
final authLoadingControllerProvider =
    AutoDisposeNotifierProvider<AuthLoadingController, AuthLoadingState>(
  AuthLoadingController.new,
);

// Convenience providers

/// Провайдер для проверки, идет ли проверка аутентификации
final isCheckingAuthProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(authLoadingControllerProvider).isCheckingAuth;
});

/// Провайдер для получения ошибки
final authLoadingErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(authLoadingControllerProvider).error;
});

// Провайдер shouldNavigateProvider больше не нужен, так как навигация
// теперь обрабатывается напрямую в AuthLoadingScreen
