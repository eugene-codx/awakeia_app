// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Failure {
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FailureCopyWith<Failure> get copyWith =>
      _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Failure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'Failure(message: $message)';
  }
}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) =
      _$FailureCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res> implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ServerFailure() when server != null:
        return server(_that);
      case NetworkFailure() when network != null:
        return network(_that);
      case AuthenticationFailure() when authentication != null:
        return authentication(_that);
      case AuthorizationFailure() when authorization != null:
        return authorization(_that);
      case ValidationFailure() when validation != null:
        return validation(_that);
      case CacheFailure() when cache != null:
        return cache(_that);
      case UnknownFailure() when unknown != null:
        return unknown(_that);
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
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    final _that = this;
    switch (_that) {
      case ServerFailure():
        return server(_that);
      case NetworkFailure():
        return network(_that);
      case AuthenticationFailure():
        return authentication(_that);
      case AuthorizationFailure():
        return authorization(_that);
      case ValidationFailure():
        return validation(_that);
      case CacheFailure():
        return cache(_that);
      case UnknownFailure():
        return unknown(_that);
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
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    final _that = this;
    switch (_that) {
      case ServerFailure() when server != null:
        return server(_that);
      case NetworkFailure() when network != null:
        return network(_that);
      case AuthenticationFailure() when authentication != null:
        return authentication(_that);
      case AuthorizationFailure() when authorization != null:
        return authorization(_that);
      case ValidationFailure() when validation != null:
        return validation(_that);
      case CacheFailure() when cache != null:
        return cache(_that);
      case UnknownFailure() when unknown != null:
        return unknown(_that);
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
    TResult Function(String message, int statusCode)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? authentication,
    TResult Function(String message)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message)? cache,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ServerFailure() when server != null:
        return server(_that.message, _that.statusCode);
      case NetworkFailure() when network != null:
        return network(_that.message);
      case AuthenticationFailure() when authentication != null:
        return authentication(_that.message);
      case AuthorizationFailure() when authorization != null:
        return authorization(_that.message);
      case ValidationFailure() when validation != null:
        return validation(_that.message, _that.errors);
      case CacheFailure() when cache != null:
        return cache(_that.message);
      case UnknownFailure() when unknown != null:
        return unknown(_that.message);
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
    required TResult Function(String message, int statusCode) server,
    required TResult Function(String message) network,
    required TResult Function(String message) authentication,
    required TResult Function(String message) authorization,
    required TResult Function(String message, Map<String, String> errors)
        validation,
    required TResult Function(String message) cache,
    required TResult Function(String message) unknown,
  }) {
    final _that = this;
    switch (_that) {
      case ServerFailure():
        return server(_that.message, _that.statusCode);
      case NetworkFailure():
        return network(_that.message);
      case AuthenticationFailure():
        return authentication(_that.message);
      case AuthorizationFailure():
        return authorization(_that.message);
      case ValidationFailure():
        return validation(_that.message, _that.errors);
      case CacheFailure():
        return cache(_that.message);
      case UnknownFailure():
        return unknown(_that.message);
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
    TResult? Function(String message, int statusCode)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? authentication,
    TResult? Function(String message)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? unknown,
  }) {
    final _that = this;
    switch (_that) {
      case ServerFailure() when server != null:
        return server(_that.message, _that.statusCode);
      case NetworkFailure() when network != null:
        return network(_that.message);
      case AuthenticationFailure() when authentication != null:
        return authentication(_that.message);
      case AuthorizationFailure() when authorization != null:
        return authorization(_that.message);
      case ValidationFailure() when validation != null:
        return validation(_that.message, _that.errors);
      case CacheFailure() when cache != null:
        return cache(_that.message);
      case UnknownFailure() when unknown != null:
        return unknown(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ServerFailure implements Failure {
  const ServerFailure(
      {this.message = 'Server error occurred', this.statusCode = 500});

  @override
  @JsonKey()
  final String message;
  @JsonKey()
  final int statusCode;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServerFailureCopyWith<ServerFailure> get copyWith =>
      _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServerFailure &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode);

  @override
  String toString() {
    return 'Failure.server(message: $message, statusCode: $statusCode)';
  }
}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(
          ServerFailure value, $Res Function(ServerFailure) _then) =
      _$ServerFailureCopyWithImpl;
  @override
  @useResult
  $Res call({String message, int statusCode});
}

/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(ServerFailure(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class NetworkFailure implements Failure {
  const NetworkFailure({this.message = 'Network connection failed'});

  @override
  @JsonKey()
  final String message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NetworkFailureCopyWith<NetworkFailure> get copyWith =>
      _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NetworkFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'Failure.network(message: $message)';
  }
}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(
          NetworkFailure value, $Res Function(NetworkFailure) _then) =
      _$NetworkFailureCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(NetworkFailure(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AuthenticationFailure implements Failure {
  const AuthenticationFailure({this.message = 'Authentication failed'});

  @override
  @JsonKey()
  final String message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthenticationFailureCopyWith<AuthenticationFailure> get copyWith =>
      _$AuthenticationFailureCopyWithImpl<AuthenticationFailure>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthenticationFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'Failure.authentication(message: $message)';
  }
}

/// @nodoc
abstract mixin class $AuthenticationFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $AuthenticationFailureCopyWith(AuthenticationFailure value,
          $Res Function(AuthenticationFailure) _then) =
      _$AuthenticationFailureCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AuthenticationFailureCopyWithImpl<$Res>
    implements $AuthenticationFailureCopyWith<$Res> {
  _$AuthenticationFailureCopyWithImpl(this._self, this._then);

  final AuthenticationFailure _self;
  final $Res Function(AuthenticationFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(AuthenticationFailure(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AuthorizationFailure implements Failure {
  const AuthorizationFailure({this.message = 'Access denied'});

  @override
  @JsonKey()
  final String message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthorizationFailureCopyWith<AuthorizationFailure> get copyWith =>
      _$AuthorizationFailureCopyWithImpl<AuthorizationFailure>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthorizationFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'Failure.authorization(message: $message)';
  }
}

/// @nodoc
abstract mixin class $AuthorizationFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $AuthorizationFailureCopyWith(AuthorizationFailure value,
          $Res Function(AuthorizationFailure) _then) =
      _$AuthorizationFailureCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AuthorizationFailureCopyWithImpl<$Res>
    implements $AuthorizationFailureCopyWith<$Res> {
  _$AuthorizationFailureCopyWithImpl(this._self, this._then);

  final AuthorizationFailure _self;
  final $Res Function(AuthorizationFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(AuthorizationFailure(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ValidationFailure implements Failure {
  const ValidationFailure(
      {this.message = 'Validation failed',
      final Map<String, String> errors = const <String, String>{}})
      : _errors = errors;

  @override
  @JsonKey()
  final String message;
  final Map<String, String> _errors;
  @JsonKey()
  Map<String, String> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ValidationFailureCopyWith<ValidationFailure> get copyWith =>
      _$ValidationFailureCopyWithImpl<ValidationFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ValidationFailure &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_errors));

  @override
  String toString() {
    return 'Failure.validation(message: $message, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class $ValidationFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $ValidationFailureCopyWith(
          ValidationFailure value, $Res Function(ValidationFailure) _then) =
      _$ValidationFailureCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Map<String, String> errors});
}

/// @nodoc
class _$ValidationFailureCopyWithImpl<$Res>
    implements $ValidationFailureCopyWith<$Res> {
  _$ValidationFailureCopyWithImpl(this._self, this._then);

  final ValidationFailure _self;
  final $Res Function(ValidationFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? errors = null,
  }) {
    return _then(ValidationFailure(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errors: null == errors
          ? _self._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class CacheFailure implements Failure {
  const CacheFailure({this.message = 'Cache operation failed'});

  @override
  @JsonKey()
  final String message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CacheFailureCopyWith<CacheFailure> get copyWith =>
      _$CacheFailureCopyWithImpl<CacheFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CacheFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'Failure.cache(message: $message)';
  }
}

/// @nodoc
abstract mixin class $CacheFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $CacheFailureCopyWith(
          CacheFailure value, $Res Function(CacheFailure) _then) =
      _$CacheFailureCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$CacheFailureCopyWithImpl<$Res> implements $CacheFailureCopyWith<$Res> {
  _$CacheFailureCopyWithImpl(this._self, this._then);

  final CacheFailure _self;
  final $Res Function(CacheFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(CacheFailure(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UnknownFailure implements Failure {
  const UnknownFailure({this.message = 'Unknown error occurred'});

  @override
  @JsonKey()
  final String message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnknownFailureCopyWith<UnknownFailure> get copyWith =>
      _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnknownFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'Failure.unknown(message: $message)';
  }
}

/// @nodoc
abstract mixin class $UnknownFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $UnknownFailureCopyWith(
          UnknownFailure value, $Res Function(UnknownFailure) _then) =
      _$UnknownFailureCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(this._self, this._then);

  final UnknownFailure _self;
  final $Res Function(UnknownFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(UnknownFailure(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
