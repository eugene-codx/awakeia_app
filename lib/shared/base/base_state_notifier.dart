import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logging/app_logger.dart';

/// Base class for Notifier with typed state
abstract class BaseStateNotifier<T> extends AutoDisposeNotifier<T> {
  /// Log actions
  void logAction(String action) {
    AppLogger.debug('$runtimeType: $action');
  }

  /// Log error
  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    AppLogger.error('$runtimeType: $message', error, stackTrace);
  }

  /// Safe state update
  void updateState(T Function(T) updater) {
    state = updater(state);
  }
}

/// Mixin for form validation in Riverpod Notifier
mixin FormValidationMixin<T> on AutoDisposeNotifier<T> {
  final Map<String, String?> _validationErrors = {};

  /// Validation errors
  Map<String, String?> get validationErrors =>
      Map.unmodifiable(_validationErrors);

  /// Check for validation errors
  bool get hasValidationErrors =>
      _validationErrors.values.any((error) => error != null);

  /// Set validation error for field
  void setFieldError(String field, String? error) {
    if (error == null) {
      _validationErrors.remove(field);
    } else {
      _validationErrors[field] = error;
    }
    // Trigger state update
    ref.notifyListeners();
  }

  /// Get validation error for field
  String? getFieldError(String field) => _validationErrors[field];

  /// Clear all validation errors
  void clearValidationErrors() {
    _validationErrors.clear();
    ref.notifyListeners();
  }

  /// Validate form
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
