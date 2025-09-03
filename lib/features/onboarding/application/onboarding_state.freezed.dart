// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OnboardingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OnboardingState()';
  }
}

/// @nodoc
class $OnboardingStateCopyWith<$Res> {
  $OnboardingStateCopyWith(
      OnboardingState _, $Res Function(OnboardingState) __);
}

/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Onboarding value)? onboarding,
    TResult Function(_FirstScreen value)? firstScreen,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Loading() when loading != null:
        return loading(_that);
      case _Onboarding() when onboarding != null:
        return onboarding(_that);
      case _FirstScreen() when firstScreen != null:
        return firstScreen(_that);
      case _Error() when error != null:
        return error(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Onboarding value) onboarding,
    required TResult Function(_FirstScreen value) firstScreen,
    required TResult Function(_Error value) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Loading():
        return loading(_that);
      case _Onboarding():
        return onboarding(_that);
      case _FirstScreen():
        return firstScreen(_that);
      case _Error():
        return error(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Onboarding value)? onboarding,
    TResult? Function(_FirstScreen value)? firstScreen,
    TResult? Function(_Error value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Loading() when loading != null:
        return loading(_that);
      case _Onboarding() when onboarding != null:
        return onboarding(_that);
      case _FirstScreen() when firstScreen != null:
        return firstScreen(_that);
      case _Error() when error != null:
        return error(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(OnboardingEntity onboarding)? onboarding,
    TResult Function()? firstScreen,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Loading() when loading != null:
        return loading();
      case _Onboarding() when onboarding != null:
        return onboarding(_that.onboarding);
      case _FirstScreen() when firstScreen != null:
        return firstScreen();
      case _Error() when error != null:
        return error(_that.message);
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
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(OnboardingEntity onboarding) onboarding,
    required TResult Function() firstScreen,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Loading():
        return loading();
      case _Onboarding():
        return onboarding(_that.onboarding);
      case _FirstScreen():
        return firstScreen();
      case _Error():
        return error(_that.message);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(OnboardingEntity onboarding)? onboarding,
    TResult? Function()? firstScreen,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Loading() when loading != null:
        return loading();
      case _Onboarding() when onboarding != null:
        return onboarding(_that.onboarding);
      case _FirstScreen() when firstScreen != null:
        return firstScreen();
      case _Error() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Loading implements OnboardingState {
  const _Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OnboardingState.loading()';
  }
}

/// @nodoc

class _Onboarding implements OnboardingState {
  const _Onboarding(this.onboarding);

  final OnboardingEntity onboarding;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OnboardingCopyWith<_Onboarding> get copyWith =>
      __$OnboardingCopyWithImpl<_Onboarding>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Onboarding &&
            (identical(other.onboarding, onboarding) ||
                other.onboarding == onboarding));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onboarding);

  @override
  String toString() {
    return 'OnboardingState.onboarding(onboarding: $onboarding)';
  }
}

/// @nodoc
abstract mixin class _$OnboardingCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingCopyWith(
          _Onboarding value, $Res Function(_Onboarding) _then) =
      __$OnboardingCopyWithImpl;
  @useResult
  $Res call({OnboardingEntity onboarding});
}

/// @nodoc
class __$OnboardingCopyWithImpl<$Res> implements _$OnboardingCopyWith<$Res> {
  __$OnboardingCopyWithImpl(this._self, this._then);

  final _Onboarding _self;
  final $Res Function(_Onboarding) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? onboarding = null,
  }) {
    return _then(_Onboarding(
      null == onboarding
          ? _self.onboarding
          : onboarding // ignore: cast_nullable_to_non_nullable
              as OnboardingEntity,
    ));
  }
}

/// @nodoc

class _FirstScreen implements OnboardingState {
  const _FirstScreen();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FirstScreen);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OnboardingState.firstScreen()';
  }
}

/// @nodoc

class _Error implements OnboardingState {
  const _Error(this.message);

  final String message;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'OnboardingState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) =
      __$ErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Error(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
