import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Расширения для удобной работы с AsyncValue
extension AsyncValueX<T> on AsyncValue<T> {
  /// Проверка, что состояние в процессе загрузки
  bool get isLoadingState => this is AsyncLoading<T>;

  /// Проверка на наличие ошибки
  bool get hasErrorState => this is AsyncError<T>;

  /// Проверка на наличие данных
  bool get hasDataState => this is AsyncData<T>;

  /// Безопасное получение данных
  T? get valueOrNull => whenOrNull(data: (value) => value);

  /// Получить ошибку если есть
  Object? get errorOrNull => whenOrNull(
        error: (error, _) => error,
      );

  /// Получить сообщение об ошибке
  String? get errorMessage => whenOrNull(
        error: (error, _) => error.toString(),
      );

  /// Выполнить действие только если есть данные
  void whenData(void Function(T value) action) {
    whenOrNull(data: action);
  }

  /// Выполнить действие только если есть ошибка
  void whenError(void Function(Object error, StackTrace stackTrace) action) {
    whenOrNull(error: action);
  }
}

/// Расширения для AsyncValue с возможностью обновления
extension AsyncValueModifierX<T> on AsyncValue<T> {
  /// Обновить данные сохраняя состояние loading/error
  AsyncValue<T> updateData(T Function(T) updater) {
    return when(
      data: (value) => AsyncData(updater(value)),
      loading: () => this,
      error: (error, stack) => this,
    );
  }

  /// Установить состояние loading сохраняя предыдущие данные
  AsyncValue<T> toLoading() {
    return whenOrNull(
          data: (value) => AsyncLoading<T>().copyWithPrevious(AsyncData(value)),
        ) ??
        const AsyncLoading();
  }

  /// Установить состояние ошибки сохраняя предыдущие данные
  AsyncValue<T> toError(Object error, StackTrace stackTrace) {
    return whenOrNull(
          data: (value) => AsyncError<T>(error, stackTrace)
              .copyWithPrevious(AsyncData(value)),
        ) ??
        AsyncError(error, stackTrace);
  }
}
