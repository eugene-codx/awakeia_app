// /// Extensions for convenient work with AsyncValue
// extension AsyncValueX<T> on AsyncValue<T> {
//   /// Check if state is loading
//   bool get isLoadingState => this is AsyncLoading<T>;
//
//   /// Check for error
//   bool get hasErrorState => this is AsyncError<T>;
//
//   /// Check for data
//   bool get hasDataState => this is AsyncData<T>;
//
//   /// Safe data retrieval
//   T? get valueOrNull => whenOrNull(data: (value) => value);
//
//   /// Get error if exists
//   Object? get errorOrNull => whenOrNull(
//         error: (error, _) => error,
//       );
//
//   /// Get error message
//   String? get errorMessage => whenOrNull(
//         error: (error, _) => error.toString(),
//       );
//
//   /// Execute action only if data exists
//   void whenData(void Function(T value) action) {
//     whenOrNull(data: action);
//   }
//
//   /// Execute action only if error exists
//   void whenError(void Function(Object error, StackTrace stackTrace) action) {
//     whenOrNull(error: action);
//   }
// }

// /// Extensions for AsyncValue with update capability
// extension AsyncValueModifierX<T> on AsyncValue<T> {
//   /// Update data preserving loading/error state
//   AsyncValue<T> updateData(T Function(T) updater) {
//     return when(
//       data: (value) => AsyncData(updater(value)),
//       loading: () => this,
//       error: (error, stack) => this,
//     );
//   }
//
//   /// Set loading state preserving previous data
//   AsyncValue<T> toLoading() {
//     return whenOrNull(
//           data: (value) => AsyncLoading<T>().copyWithPrevious(AsyncData(value)),
//         ) ??
//         const AsyncLoading();
//   }
//
//   /// Set error state preserving previous data
//   AsyncValue<T> toError(Object error, StackTrace stackTrace) {
//     return whenOrNull(
//           data: (value) => AsyncError<T>(error, stackTrace)
//               .copyWithPrevious(AsyncData(value)),
//         ) ??
//         AsyncError(error, stackTrace);
//   }
// }
