// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeState {
  int get selectedTabIndex;
  int get todayCompletedHabits;
  int get totalHabitsToday;
  int get currentStreak;
  bool get hasHabits;
  bool get isLoading;
  String? get error;
  bool get isRefreshing;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeStateCopyWith<HomeState> get copyWith =>
      _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeState &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.todayCompletedHabits, todayCompletedHabits) ||
                other.todayCompletedHabits == todayCompletedHabits) &&
            (identical(other.totalHabitsToday, totalHabitsToday) ||
                other.totalHabitsToday == totalHabitsToday) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.hasHabits, hasHabits) ||
                other.hasHabits == hasHabits) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedTabIndex,
      todayCompletedHabits,
      totalHabitsToday,
      currentStreak,
      hasHabits,
      isLoading,
      error,
      isRefreshing);

  @override
  String toString() {
    return 'HomeState(selectedTabIndex: $selectedTabIndex, todayCompletedHabits: $todayCompletedHabits, totalHabitsToday: $totalHabitsToday, currentStreak: $currentStreak, hasHabits: $hasHabits, isLoading: $isLoading, error: $error, isRefreshing: $isRefreshing)';
  }
}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) =
      _$HomeStateCopyWithImpl;
  @useResult
  $Res call(
      {int selectedTabIndex,
      int todayCompletedHabits,
      int totalHabitsToday,
      int currentStreak,
      bool hasHabits,
      bool isLoading,
      String? error,
      bool isRefreshing});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTabIndex = null,
    Object? todayCompletedHabits = null,
    Object? totalHabitsToday = null,
    Object? currentStreak = null,
    Object? hasHabits = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? isRefreshing = null,
  }) {
    return _then(_self.copyWith(
      selectedTabIndex: null == selectedTabIndex
          ? _self.selectedTabIndex
          : selectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      todayCompletedHabits: null == todayCompletedHabits
          ? _self.todayCompletedHabits
          : todayCompletedHabits // ignore: cast_nullable_to_non_nullable
              as int,
      totalHabitsToday: null == totalHabitsToday
          ? _self.totalHabitsToday
          : totalHabitsToday // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      hasHabits: null == hasHabits
          ? _self.hasHabits
          : hasHabits // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isRefreshing: null == isRefreshing
          ? _self.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HomeState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_HomeState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HomeState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int selectedTabIndex,
            int todayCompletedHabits,
            int totalHabitsToday,
            int currentStreak,
            bool hasHabits,
            bool isLoading,
            String? error,
            bool isRefreshing)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeState() when $default != null:
        return $default(
            _that.selectedTabIndex,
            _that.todayCompletedHabits,
            _that.totalHabitsToday,
            _that.currentStreak,
            _that.hasHabits,
            _that.isLoading,
            _that.error,
            _that.isRefreshing);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int selectedTabIndex,
            int todayCompletedHabits,
            int totalHabitsToday,
            int currentStreak,
            bool hasHabits,
            bool isLoading,
            String? error,
            bool isRefreshing)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeState():
        return $default(
            _that.selectedTabIndex,
            _that.todayCompletedHabits,
            _that.totalHabitsToday,
            _that.currentStreak,
            _that.hasHabits,
            _that.isLoading,
            _that.error,
            _that.isRefreshing);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int selectedTabIndex,
            int todayCompletedHabits,
            int totalHabitsToday,
            int currentStreak,
            bool hasHabits,
            bool isLoading,
            String? error,
            bool isRefreshing)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeState() when $default != null:
        return $default(
            _that.selectedTabIndex,
            _that.todayCompletedHabits,
            _that.totalHabitsToday,
            _that.currentStreak,
            _that.hasHabits,
            _that.isLoading,
            _that.error,
            _that.isRefreshing);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HomeState extends HomeState {
  const _HomeState(
      {this.selectedTabIndex = 0,
      this.todayCompletedHabits = 0,
      this.totalHabitsToday = 0,
      this.currentStreak = 0,
      this.hasHabits = false,
      this.isLoading = false,
      this.error,
      this.isRefreshing = false})
      : super._();

  @override
  @JsonKey()
  final int selectedTabIndex;
  @override
  @JsonKey()
  final int todayCompletedHabits;
  @override
  @JsonKey()
  final int totalHabitsToday;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final bool hasHabits;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isRefreshing;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeState &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.todayCompletedHabits, todayCompletedHabits) ||
                other.todayCompletedHabits == todayCompletedHabits) &&
            (identical(other.totalHabitsToday, totalHabitsToday) ||
                other.totalHabitsToday == totalHabitsToday) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.hasHabits, hasHabits) ||
                other.hasHabits == hasHabits) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedTabIndex,
      todayCompletedHabits,
      totalHabitsToday,
      currentStreak,
      hasHabits,
      isLoading,
      error,
      isRefreshing);

  @override
  String toString() {
    return 'HomeState(selectedTabIndex: $selectedTabIndex, todayCompletedHabits: $todayCompletedHabits, totalHabitsToday: $totalHabitsToday, currentStreak: $currentStreak, hasHabits: $hasHabits, isLoading: $isLoading, error: $error, isRefreshing: $isRefreshing)';
  }
}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(
          _HomeState value, $Res Function(_HomeState) _then) =
      __$HomeStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int selectedTabIndex,
      int todayCompletedHabits,
      int totalHabitsToday,
      int currentStreak,
      bool hasHabits,
      bool isLoading,
      String? error,
      bool isRefreshing});
}

/// @nodoc
class __$HomeStateCopyWithImpl<$Res> implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedTabIndex = null,
    Object? todayCompletedHabits = null,
    Object? totalHabitsToday = null,
    Object? currentStreak = null,
    Object? hasHabits = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? isRefreshing = null,
  }) {
    return _then(_HomeState(
      selectedTabIndex: null == selectedTabIndex
          ? _self.selectedTabIndex
          : selectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      todayCompletedHabits: null == todayCompletedHabits
          ? _self.todayCompletedHabits
          : todayCompletedHabits // ignore: cast_nullable_to_non_nullable
              as int,
      totalHabitsToday: null == totalHabitsToday
          ? _self.totalHabitsToday
          : totalHabitsToday // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      hasHabits: null == hasHabits
          ? _self.hasHabits
          : hasHabits // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isRefreshing: null == isRefreshing
          ? _self.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
