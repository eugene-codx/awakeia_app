import 'package:flutter/foundation.dart';

/// Базовый класс для всех view models в приложении
/// Предоставляет общий функционал для управления состоянием UI
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _disposed = false;

  /// Флаг загрузки
  bool get isLoading => _isLoading;

  /// Текущая ошибка
  String? get error => _error;

  /// Проверка на наличие ошибки
  bool get hasError => _error != null;

  /// Проверка что view model не disposed
  bool get isDisposed => _disposed;

  /// Установить состояние загрузки
  void setLoading(bool loading) {
    if (_disposed) return;

    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Установить ошибку
  void setError(String? error) {
    if (_disposed) return;

    if (_error != error) {
      _error = error;
      notifyListeners();
    }
  }

  /// Очистить ошибку
  void clearError() => setError(null);

  /// Выполнить операцию с автоматическим управлением состоянием loading
  Future<T?> executeWithLoading<T>(
    Future<T> Function() operation, {
    bool showError = true,
  }) async {
    try {
      setLoading(true);
      clearError();

      final result = await operation();
      return result;
    } catch (e) {
      if (showError) {
        setError(e.toString());
      }
      return null;
    } finally {
      setLoading(false);
    }
  }

  /// Безопасное уведомление об изменениях
  void safeNotifyListeners() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// Базовый класс для view models с типизированным состоянием
abstract class BaseViewModelWithState<T> extends BaseViewModel {
  T? _state;

  /// Текущее состояние
  T? get state => _state;

  /// Проверка на наличие состояния
  bool get hasState => _state != null;

  /// Установить новое состояние
  void setState(T? newState) {
    if (_disposed) return;

    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  /// Обновить состояние через функцию
  void updateState(T Function(T?) updater) {
    setState(updater(_state));
  }
}

/// Миксин для валидации форм
mixin FormValidationMixin on BaseViewModel {
  final Map<String, String?> _validationErrors = {};

  /// Ошибки валидации
  Map<String, String?> get validationErrors =>
      Map.unmodifiable(_validationErrors);

  /// Проверка на наличие ошибок валидации
  bool get hasValidationErrors => _validationErrors.isNotEmpty;

  /// Установить ошибку валидации для поля
  void setValidationError(String field, String? error) {
    if (error == null) {
      _validationErrors.remove(field);
    } else {
      _validationErrors[field] = error;
    }
    safeNotifyListeners();
  }

  /// Получить ошибку валидации для поля
  String? getValidationError(String field) => _validationErrors[field];

  /// Очистить все ошибки валидации
  void clearValidationErrors() {
    if (_validationErrors.isNotEmpty) {
      _validationErrors.clear();
      safeNotifyListeners();
    }
  }

  /// Очистить ошибку валидации для конкретного поля
  void clearValidationError(String field) {
    if (_validationErrors.remove(field) != null) {
      safeNotifyListeners();
    }
  }

  /// Проверить валидность всех полей
  bool validateForm(Map<String, String? Function()> validators) {
    clearValidationErrors();

    bool isValid = true;
    for (final entry in validators.entries) {
      final error = entry.value();
      if (error != null) {
        setValidationError(entry.key, error);
        isValid = false;
      }
    }

    return isValid;
  }
}
