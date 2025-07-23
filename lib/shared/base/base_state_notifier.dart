import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logging/app_logger.dart';

/// Базовый класс для Notifier с типизированным состоянием
/// Заменяет BaseViewModelWithState
abstract class BaseStateNotifier<T> extends AutoDisposeNotifier<T> {
  /// Логировать действия
  void logAction(String action) {
    AppLogger.debug('$runtimeType: $action');
  }

  /// Логировать ошибку
  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    AppLogger.error('$runtimeType: $message', error, stackTrace);
  }

  /// Безопасное обновление состояния
  void updateState(T Function(T) updater) {
    state = updater(state);
  }
}

/// Базовый класс для AsyncNotifier
/// Заменяет BaseViewModel с loading/error состояниями
abstract class BaseAsyncNotifier<T> extends AutoDisposeAsyncNotifier<T> {
  /// Логировать действия
  void logAction(String action) {
    AppLogger.debug('$runtimeType: $action');
  }

  /// Логировать ошибку
  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    AppLogger.error('$runtimeType: $message', error, stackTrace);
  }

  /// Выполнить операцию с автоматическим управлением состояния loading
  Future<T?> executeAsync(
    Future<T> Function() operation, {
    bool keepPreviousData = true,
  }) async {
    try {
      // Устанавливаем loading, сохраняя предыдущие данные если нужно
      if (keepPreviousData && state.hasValue) {
        state = AsyncLoading<T>().copyWithPrevious(state);
      } else {
        state = const AsyncLoading();
      }

      final result = await operation();
      state = AsyncData(result);
      return result;
    } catch (error, stackTrace) {
      logError('Operation failed', error, stackTrace);

      // Устанавливаем error, сохраняя предыдущие данные если нужно
      if (keepPreviousData && state.hasValue) {
        state = AsyncError<T>(error, stackTrace).copyWithPrevious(state);
      } else {
        state = AsyncError(error, stackTrace);
      }

      return null;
    }
  }

  /// Обновить данные если они есть
  void updateData(T Function(T) updater) {
    state.whenData((value) {
      state = AsyncData(updater(value));
    });
  }

  /// Установить ошибку
  void setError(Object error, [StackTrace? stackTrace]) {
    state = AsyncError(error, stackTrace ?? StackTrace.current);
  }

  /// Очистить ошибку и вернуться к данным
  void clearError() {
    if (state.hasValue) {
      state = AsyncData(state.value as T);
    }
  }
}

/// Миксин для валидации форм в Riverpod Notifier
mixin FormValidationMixin<T> on AutoDisposeNotifier<T> {
  final Map<String, String?> _validationErrors = {};

  /// Ошибки валидации
  Map<String, String?> get validationErrors =>
      Map.unmodifiable(_validationErrors);

  /// Проверка на наличие ошибок валидации
  bool get hasValidationErrors =>
      _validationErrors.values.any((error) => error != null);

  /// Установить ошибку валидации для поля
  void setFieldError(String field, String? error) {
    if (error == null) {
      _validationErrors.remove(field);
    } else {
      _validationErrors[field] = error;
    }
    // Триггерим обновление состояния
    ref.notifyListeners();
  }

  /// Получить ошибку валидации для поля
  String? getFieldError(String field) => _validationErrors[field];

  /// Очистить все ошибки валидации
  void clearValidationErrors() {
    _validationErrors.clear();
    ref.notifyListeners();
  }

  /// Валидировать форму
  bool validateForm(Map<String, String? Function()> validators) {
    clearValidationErrors();

    bool isValid = true;
    for (final entry in validators.entries) {
      final error = entry.value();
      if (error != null) {
        setFieldError(entry.key, error);
        isValid = false;
      }
    }

    return isValid;
  }
}
