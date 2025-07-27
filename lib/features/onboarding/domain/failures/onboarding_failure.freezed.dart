// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingFailure {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OnboardingFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OnboardingFailure()';
  }
}

/// @nodoc
class $OnboardingFailureCopyWith<$Res> {
  $OnboardingFailureCopyWith(
      OnboardingFailure _, $Res Function(OnboardingFailure) __);
}

/// Adds pattern-matching-related methods to [OnboardingFailure].
extension OnboardingFailurePatterns on OnboardingFailure {
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
    TResult Function(StorageError value)? storageError,
    TResult Function(InvalidState value)? invalidState,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StorageError() when storageError != null:
        return storageError(_that);
      case InvalidState() when invalidState != null:
        return invalidState(_that);
      case UnexpectedError() when unexpectedError != null:
        return unexpectedError(_that);
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
    required TResult Function(StorageError value) storageError,
    required TResult Function(InvalidState value) invalidState,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    final _that = this;
    switch (_that) {
      case StorageError():
        return storageError(_that);
      case InvalidState():
        return invalidState(_that);
      case UnexpectedError():
        return unexpectedError(_that);
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
    TResult? Function(StorageError value)? storageError,
    TResult? Function(InvalidState value)? invalidState,
    TResult? Function(UnexpectedError value)? unexpectedError,
  }) {
    final _that = this;
    switch (_that) {
      case StorageError() when storageError != null:
        return storageError(_that);
      case InvalidState() when invalidState != null:
        return invalidState(_that);
      case UnexpectedError() when unexpectedError != null:
        return unexpectedError(_that);
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
    TResult Function()? storageError,
    TResult Function()? invalidState,
    TResult Function(String message)? unexpectedError,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StorageError() when storageError != null:
        return storageError();
      case InvalidState() when invalidState != null:
        return invalidState();
      case UnexpectedError() when unexpectedError != null:
        return unexpectedError(_that.message);
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
    required TResult Function() storageError,
    required TResult Function() invalidState,
    required TResult Function(String message) unexpectedError,
  }) {
    final _that = this;
    switch (_that) {
      case StorageError():
        return storageError();
      case InvalidState():
        return invalidState();
      case UnexpectedError():
        return unexpectedError(_that.message);
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
    TResult? Function()? storageError,
    TResult? Function()? invalidState,
    TResult? Function(String message)? unexpectedError,
  }) {
    final _that = this;
    switch (_that) {
      case StorageError() when storageError != null:
        return storageError();
      case InvalidState() when invalidState != null:
        return invalidState();
      case UnexpectedError() when unexpectedError != null:
        return unexpectedError(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class StorageError extends OnboardingFailure {
  const StorageError() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StorageError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OnboardingFailure.storageError()';
  }
}

/// @nodoc

class InvalidState extends OnboardingFailure {
  const InvalidState() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InvalidState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OnboardingFailure.invalidState()';
  }
}

/// @nodoc

class UnexpectedError extends OnboardingFailure {
  const UnexpectedError(this.message) : super._();

  final String message;

  /// Create a copy of OnboardingFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnexpectedErrorCopyWith<UnexpectedError> get copyWith =>
      _$UnexpectedErrorCopyWithImpl<UnexpectedError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnexpectedError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'OnboardingFailure.unexpectedError(message: $message)';
  }
}

/// @nodoc
abstract mixin class $UnexpectedErrorCopyWith<$Res>
    implements $OnboardingFailureCopyWith<$Res> {
  factory $UnexpectedErrorCopyWith(
          UnexpectedError value, $Res Function(UnexpectedError) _then) =
      _$UnexpectedErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$UnexpectedErrorCopyWithImpl<$Res>
    implements $UnexpectedErrorCopyWith<$Res> {
  _$UnexpectedErrorCopyWithImpl(this._self, this._then);

  final UnexpectedError _self;
  final $Res Function(UnexpectedError) _then;

  /// Create a copy of OnboardingFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(UnexpectedError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
