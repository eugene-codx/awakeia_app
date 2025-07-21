// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthFailure {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
class $AuthFailureCopyWith<$Res> {
  $AuthFailureCopyWith(AuthFailure _, $Res Function(AuthFailure) __);
}

/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
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
    TResult Function(_ServerError value)? serverError,
    TResult Function(_EmailAlreadyInUse value)? emailAlreadyInUse,
    TResult Function(_InvalidEmailAndPasswordCombination value)?
        invalidEmailAndPasswordCombination,
    TResult Function(_InvalidEmail value)? invalidEmail,
    TResult Function(_WeakPassword value)? weakPassword,
    TResult Function(_UserNotFound value)? userNotFound,
    TResult Function(_UserDisabled value)? userDisabled,
    TResult Function(_TooManyRequests value)? tooManyRequests,
    TResult Function(_OperationNotAllowed value)? operationNotAllowed,
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_UnexpectedError value)? unexpectedError,
    TResult Function(_StorageError value)? storageError,
    TResult Function(_TokenExpired value)? tokenExpired,
    TResult Function(_NoAuthToken value)? noAuthToken,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServerError() when serverError != null:
        return serverError(_that);
      case _EmailAlreadyInUse() when emailAlreadyInUse != null:
        return emailAlreadyInUse(_that);
      case _InvalidEmailAndPasswordCombination()
          when invalidEmailAndPasswordCombination != null:
        return invalidEmailAndPasswordCombination(_that);
      case _InvalidEmail() when invalidEmail != null:
        return invalidEmail(_that);
      case _WeakPassword() when weakPassword != null:
        return weakPassword(_that);
      case _UserNotFound() when userNotFound != null:
        return userNotFound(_that);
      case _UserDisabled() when userDisabled != null:
        return userDisabled(_that);
      case _TooManyRequests() when tooManyRequests != null:
        return tooManyRequests(_that);
      case _OperationNotAllowed() when operationNotAllowed != null:
        return operationNotAllowed(_that);
      case _NetworkError() when networkError != null:
        return networkError(_that);
      case _UnexpectedError() when unexpectedError != null:
        return unexpectedError(_that);
      case _StorageError() when storageError != null:
        return storageError(_that);
      case _TokenExpired() when tokenExpired != null:
        return tokenExpired(_that);
      case _NoAuthToken() when noAuthToken != null:
        return noAuthToken(_that);
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
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_EmailAlreadyInUse value) emailAlreadyInUse,
    required TResult Function(_InvalidEmailAndPasswordCombination value)
        invalidEmailAndPasswordCombination,
    required TResult Function(_InvalidEmail value) invalidEmail,
    required TResult Function(_WeakPassword value) weakPassword,
    required TResult Function(_UserNotFound value) userNotFound,
    required TResult Function(_UserDisabled value) userDisabled,
    required TResult Function(_TooManyRequests value) tooManyRequests,
    required TResult Function(_OperationNotAllowed value) operationNotAllowed,
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_UnexpectedError value) unexpectedError,
    required TResult Function(_StorageError value) storageError,
    required TResult Function(_TokenExpired value) tokenExpired,
    required TResult Function(_NoAuthToken value) noAuthToken,
  }) {
    final _that = this;
    switch (_that) {
      case _ServerError():
        return serverError(_that);
      case _EmailAlreadyInUse():
        return emailAlreadyInUse(_that);
      case _InvalidEmailAndPasswordCombination():
        return invalidEmailAndPasswordCombination(_that);
      case _InvalidEmail():
        return invalidEmail(_that);
      case _WeakPassword():
        return weakPassword(_that);
      case _UserNotFound():
        return userNotFound(_that);
      case _UserDisabled():
        return userDisabled(_that);
      case _TooManyRequests():
        return tooManyRequests(_that);
      case _OperationNotAllowed():
        return operationNotAllowed(_that);
      case _NetworkError():
        return networkError(_that);
      case _UnexpectedError():
        return unexpectedError(_that);
      case _StorageError():
        return storageError(_that);
      case _TokenExpired():
        return tokenExpired(_that);
      case _NoAuthToken():
        return noAuthToken(_that);
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
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_EmailAlreadyInUse value)? emailAlreadyInUse,
    TResult? Function(_InvalidEmailAndPasswordCombination value)?
        invalidEmailAndPasswordCombination,
    TResult? Function(_InvalidEmail value)? invalidEmail,
    TResult? Function(_WeakPassword value)? weakPassword,
    TResult? Function(_UserNotFound value)? userNotFound,
    TResult? Function(_UserDisabled value)? userDisabled,
    TResult? Function(_TooManyRequests value)? tooManyRequests,
    TResult? Function(_OperationNotAllowed value)? operationNotAllowed,
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_UnexpectedError value)? unexpectedError,
    TResult? Function(_StorageError value)? storageError,
    TResult? Function(_TokenExpired value)? tokenExpired,
    TResult? Function(_NoAuthToken value)? noAuthToken,
  }) {
    final _that = this;
    switch (_that) {
      case _ServerError() when serverError != null:
        return serverError(_that);
      case _EmailAlreadyInUse() when emailAlreadyInUse != null:
        return emailAlreadyInUse(_that);
      case _InvalidEmailAndPasswordCombination()
          when invalidEmailAndPasswordCombination != null:
        return invalidEmailAndPasswordCombination(_that);
      case _InvalidEmail() when invalidEmail != null:
        return invalidEmail(_that);
      case _WeakPassword() when weakPassword != null:
        return weakPassword(_that);
      case _UserNotFound() when userNotFound != null:
        return userNotFound(_that);
      case _UserDisabled() when userDisabled != null:
        return userDisabled(_that);
      case _TooManyRequests() when tooManyRequests != null:
        return tooManyRequests(_that);
      case _OperationNotAllowed() when operationNotAllowed != null:
        return operationNotAllowed(_that);
      case _NetworkError() when networkError != null:
        return networkError(_that);
      case _UnexpectedError() when unexpectedError != null:
        return unexpectedError(_that);
      case _StorageError() when storageError != null:
        return storageError(_that);
      case _TokenExpired() when tokenExpired != null:
        return tokenExpired(_that);
      case _NoAuthToken() when noAuthToken != null:
        return noAuthToken(_that);
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
    TResult Function(String? message)? serverError,
    TResult Function()? emailAlreadyInUse,
    TResult Function()? invalidEmailAndPasswordCombination,
    TResult Function()? invalidEmail,
    TResult Function()? weakPassword,
    TResult Function()? userNotFound,
    TResult Function()? userDisabled,
    TResult Function()? tooManyRequests,
    TResult Function()? operationNotAllowed,
    TResult Function()? networkError,
    TResult Function(String? message)? unexpectedError,
    TResult Function()? storageError,
    TResult Function()? tokenExpired,
    TResult Function()? noAuthToken,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServerError() when serverError != null:
        return serverError(_that.message);
      case _EmailAlreadyInUse() when emailAlreadyInUse != null:
        return emailAlreadyInUse();
      case _InvalidEmailAndPasswordCombination()
          when invalidEmailAndPasswordCombination != null:
        return invalidEmailAndPasswordCombination();
      case _InvalidEmail() when invalidEmail != null:
        return invalidEmail();
      case _WeakPassword() when weakPassword != null:
        return weakPassword();
      case _UserNotFound() when userNotFound != null:
        return userNotFound();
      case _UserDisabled() when userDisabled != null:
        return userDisabled();
      case _TooManyRequests() when tooManyRequests != null:
        return tooManyRequests();
      case _OperationNotAllowed() when operationNotAllowed != null:
        return operationNotAllowed();
      case _NetworkError() when networkError != null:
        return networkError();
      case _UnexpectedError() when unexpectedError != null:
        return unexpectedError(_that.message);
      case _StorageError() when storageError != null:
        return storageError();
      case _TokenExpired() when tokenExpired != null:
        return tokenExpired();
      case _NoAuthToken() when noAuthToken != null:
        return noAuthToken();
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
    required TResult Function(String? message) serverError,
    required TResult Function() emailAlreadyInUse,
    required TResult Function() invalidEmailAndPasswordCombination,
    required TResult Function() invalidEmail,
    required TResult Function() weakPassword,
    required TResult Function() userNotFound,
    required TResult Function() userDisabled,
    required TResult Function() tooManyRequests,
    required TResult Function() operationNotAllowed,
    required TResult Function() networkError,
    required TResult Function(String? message) unexpectedError,
    required TResult Function() storageError,
    required TResult Function() tokenExpired,
    required TResult Function() noAuthToken,
  }) {
    final _that = this;
    switch (_that) {
      case _ServerError():
        return serverError(_that.message);
      case _EmailAlreadyInUse():
        return emailAlreadyInUse();
      case _InvalidEmailAndPasswordCombination():
        return invalidEmailAndPasswordCombination();
      case _InvalidEmail():
        return invalidEmail();
      case _WeakPassword():
        return weakPassword();
      case _UserNotFound():
        return userNotFound();
      case _UserDisabled():
        return userDisabled();
      case _TooManyRequests():
        return tooManyRequests();
      case _OperationNotAllowed():
        return operationNotAllowed();
      case _NetworkError():
        return networkError();
      case _UnexpectedError():
        return unexpectedError(_that.message);
      case _StorageError():
        return storageError();
      case _TokenExpired():
        return tokenExpired();
      case _NoAuthToken():
        return noAuthToken();
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
    TResult? Function(String? message)? serverError,
    TResult? Function()? emailAlreadyInUse,
    TResult? Function()? invalidEmailAndPasswordCombination,
    TResult? Function()? invalidEmail,
    TResult? Function()? weakPassword,
    TResult? Function()? userNotFound,
    TResult? Function()? userDisabled,
    TResult? Function()? tooManyRequests,
    TResult? Function()? operationNotAllowed,
    TResult? Function()? networkError,
    TResult? Function(String? message)? unexpectedError,
    TResult? Function()? storageError,
    TResult? Function()? tokenExpired,
    TResult? Function()? noAuthToken,
  }) {
    final _that = this;
    switch (_that) {
      case _ServerError() when serverError != null:
        return serverError(_that.message);
      case _EmailAlreadyInUse() when emailAlreadyInUse != null:
        return emailAlreadyInUse();
      case _InvalidEmailAndPasswordCombination()
          when invalidEmailAndPasswordCombination != null:
        return invalidEmailAndPasswordCombination();
      case _InvalidEmail() when invalidEmail != null:
        return invalidEmail();
      case _WeakPassword() when weakPassword != null:
        return weakPassword();
      case _UserNotFound() when userNotFound != null:
        return userNotFound();
      case _UserDisabled() when userDisabled != null:
        return userDisabled();
      case _TooManyRequests() when tooManyRequests != null:
        return tooManyRequests();
      case _OperationNotAllowed() when operationNotAllowed != null:
        return operationNotAllowed();
      case _NetworkError() when networkError != null:
        return networkError();
      case _UnexpectedError() when unexpectedError != null:
        return unexpectedError(_that.message);
      case _StorageError() when storageError != null:
        return storageError();
      case _TokenExpired() when tokenExpired != null:
        return tokenExpired();
      case _NoAuthToken() when noAuthToken != null:
        return noAuthToken();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ServerError extends AuthFailure {
  const _ServerError([this.message]) : super._();

  final String? message;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServerErrorCopyWith<_ServerError> get copyWith =>
      __$ServerErrorCopyWithImpl<_ServerError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServerError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);
}

/// @nodoc
abstract mixin class _$ServerErrorCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$ServerErrorCopyWith(
          _ServerError value, $Res Function(_ServerError) _then) =
      __$ServerErrorCopyWithImpl;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$ServerErrorCopyWithImpl<$Res> implements _$ServerErrorCopyWith<$Res> {
  __$ServerErrorCopyWithImpl(this._self, this._then);

  final _ServerError _self;
  final $Res Function(_ServerError) _then;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_ServerError(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _EmailAlreadyInUse extends AuthFailure {
  const _EmailAlreadyInUse() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _EmailAlreadyInUse);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _InvalidEmailAndPasswordCombination extends AuthFailure {
  const _InvalidEmailAndPasswordCombination() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InvalidEmailAndPasswordCombination);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _InvalidEmail extends AuthFailure {
  const _InvalidEmail() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _InvalidEmail);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _WeakPassword extends AuthFailure {
  const _WeakPassword() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _WeakPassword);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _UserNotFound extends AuthFailure {
  const _UserNotFound() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _UserNotFound);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _UserDisabled extends AuthFailure {
  const _UserDisabled() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _UserDisabled);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _TooManyRequests extends AuthFailure {
  const _TooManyRequests() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _TooManyRequests);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _OperationNotAllowed extends AuthFailure {
  const _OperationNotAllowed() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _OperationNotAllowed);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _NetworkError extends AuthFailure {
  const _NetworkError() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NetworkError);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _UnexpectedError extends AuthFailure {
  const _UnexpectedError([this.message]) : super._();

  final String? message;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnexpectedErrorCopyWith<_UnexpectedError> get copyWith =>
      __$UnexpectedErrorCopyWithImpl<_UnexpectedError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnexpectedError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);
}

/// @nodoc
abstract mixin class _$UnexpectedErrorCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$UnexpectedErrorCopyWith(
          _UnexpectedError value, $Res Function(_UnexpectedError) _then) =
      __$UnexpectedErrorCopyWithImpl;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$UnexpectedErrorCopyWithImpl<$Res>
    implements _$UnexpectedErrorCopyWith<$Res> {
  __$UnexpectedErrorCopyWithImpl(this._self, this._then);

  final _UnexpectedError _self;
  final $Res Function(_UnexpectedError) _then;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_UnexpectedError(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _StorageError extends AuthFailure {
  const _StorageError() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _StorageError);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _TokenExpired extends AuthFailure {
  const _TokenExpired() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _TokenExpired);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc

class _NoAuthToken extends AuthFailure {
  const _NoAuthToken() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NoAuthToken);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

// dart format on
