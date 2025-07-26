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
    @Default(false) bool hasNavigated,
    String? error,
  }) = _AuthLoadingState;
}

/// Контроллер для экрана загрузки аутентификации (замена AuthLoadingViewModel)
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
    if (state.hasNavigated) {
      logAction('Already navigated, ignoring auth state change');
      return;
    }

    // Используем методы из AuthState для проверки
    if (authState.isInitial) {
      logAction('Auth state is initial, waiting...');
      state = state.copyWith(isCheckingAuth: true);
    } else if (authState.isLoading) {
      logAction('Auth state is loading, waiting...');
      state = state.copyWith(isCheckingAuth: true);
    } else if (authState.isAuthenticated) {
      logAction('User is authenticated');
      state = state.copyWith(
        isCheckingAuth: false,
        hasNavigated: true,
      );
      // Навигация будет обработана в UI
    } else if (authState.isUnauthenticated) {
      logAction('User is not authenticated');
      state = state.copyWith(
        isCheckingAuth: false,
        hasNavigated: true,
      );
      // Навигация будет обработана в UI
    }
  }

  /// Проверить состояние аутентификации вручную
  void checkAuthStatus() {
    if (state.hasNavigated) {
      logAction('Already navigated, skipping manual check');
      return;
    }

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
          hasNavigated: true,
        );
      },
    );
  }

  /// Сброс состояния навигации (для тестирования)
  void resetNavigation() {
    logAction('Resetting navigation state');
    state = state.copyWith(hasNavigated: false);
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

/// Провайдер для проверки, была ли выполнена навигация
final hasNavigatedProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(authLoadingControllerProvider).hasNavigated;
});

/// Провайдер для получения ошибки
final authLoadingErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(authLoadingControllerProvider).error;
});

/// Провайдер для определения необходимости навигации
final shouldNavigateProvider = Provider.autoDispose<NavigationTarget?>((ref) {
  final state = ref.watch(authLoadingControllerProvider);
  final authState = ref.watch(authNotifierProvider).valueOrNull;

  // Если уже навигировали или еще проверяем - не навигируем
  if (state.hasNavigated || state.isCheckingAuth) {
    return null;
  }

  // Если есть ошибка - навигируем на первый экран
  if (state.error != null) {
    return NavigationTarget.first;
  }

  // Определяем куда навигировать на основе состояния аутентификации
  if (authState != null) {
    if (authState.isAuthenticated) {
      return NavigationTarget.home;
    } else if (authState.isUnauthenticated) {
      return NavigationTarget.first;
    }
  }

  return null;
});

/// Цель навигации
enum NavigationTarget { home, first }
