// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_loading_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthLoadingState {
  bool get isCheckingAuth;
  String? get error;

  /// Create a copy of AuthLoadingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthLoadingStateCopyWith<AuthLoadingState> get copyWith =>
      _$AuthLoadingStateCopyWithImpl<AuthLoadingState>(
          this as AuthLoadingState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthLoadingState &&
            (identical(other.isCheckingAuth, isCheckingAuth) ||
                other.isCheckingAuth == isCheckingAuth) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCheckingAuth, error);

  @override
  String toString() {
    return 'AuthLoadingState(isCheckingAuth: $isCheckingAuth, error: $error)';
  }
}

/// @nodoc
abstract mixin class $AuthLoadingStateCopyWith<$Res> {
  factory $AuthLoadingStateCopyWith(
          AuthLoadingState value, $Res Function(AuthLoadingState) _then) =
      _$AuthLoadingStateCopyWithImpl;
  @useResult
  $Res call({bool isCheckingAuth, String? error});
}

/// @nodoc
class _$AuthLoadingStateCopyWithImpl<$Res>
    implements $AuthLoadingStateCopyWith<$Res> {
  _$AuthLoadingStateCopyWithImpl(this._self, this._then);

  final AuthLoadingState _self;
  final $Res Function(AuthLoadingState) _then;

  /// Create a copy of AuthLoadingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCheckingAuth = null,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      isCheckingAuth: null == isCheckingAuth
          ? _self.isCheckingAuth
          : isCheckingAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AuthLoadingState].
extension AuthLoadingStatePatterns on AuthLoadingState {
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
    TResult Function(_AuthLoadingState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthLoadingState() when $default != null:
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
    TResult Function(_AuthLoadingState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthLoadingState():
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
    TResult? Function(_AuthLoadingState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthLoadingState() when $default != null:
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
    TResult Function(bool isCheckingAuth, String? error)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthLoadingState() when $default != null:
        return $default(_that.isCheckingAuth, _that.error);
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
    TResult Function(bool isCheckingAuth, String? error) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthLoadingState():
        return $default(_that.isCheckingAuth, _that.error);
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
    TResult? Function(bool isCheckingAuth, String? error)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthLoadingState() when $default != null:
        return $default(_that.isCheckingAuth, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AuthLoadingState implements AuthLoadingState {
  const _AuthLoadingState({this.isCheckingAuth = true, this.error});

  @override
  @JsonKey()
  final bool isCheckingAuth;
  @override
  final String? error;

  /// Create a copy of AuthLoadingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthLoadingStateCopyWith<_AuthLoadingState> get copyWith =>
      __$AuthLoadingStateCopyWithImpl<_AuthLoadingState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthLoadingState &&
            (identical(other.isCheckingAuth, isCheckingAuth) ||
                other.isCheckingAuth == isCheckingAuth) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCheckingAuth, error);

  @override
  String toString() {
    return 'AuthLoadingState(isCheckingAuth: $isCheckingAuth, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$AuthLoadingStateCopyWith<$Res>
    implements $AuthLoadingStateCopyWith<$Res> {
  factory _$AuthLoadingStateCopyWith(
          _AuthLoadingState value, $Res Function(_AuthLoadingState) _then) =
      __$AuthLoadingStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isCheckingAuth, String? error});
}

/// @nodoc
class __$AuthLoadingStateCopyWithImpl<$Res>
    implements _$AuthLoadingStateCopyWith<$Res> {
  __$AuthLoadingStateCopyWithImpl(this._self, this._then);

  final _AuthLoadingState _self;
  final $Res Function(_AuthLoadingState) _then;

  /// Create a copy of AuthLoadingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCheckingAuth = null,
    Object? error = freezed,
  }) {
    return _then(_AuthLoadingState(
      isCheckingAuth: null == isCheckingAuth
          ? _self.isCheckingAuth
          : isCheckingAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
