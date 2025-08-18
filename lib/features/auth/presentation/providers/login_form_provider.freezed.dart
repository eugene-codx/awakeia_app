// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginFormState {
  String get emailUsername;
  String get password;
  bool get isPasswordHidden;
  String? get emailUsernameError;
  String? get passwordError;
  bool get isLoading;
  String? get generalError;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginFormStateCopyWith<LoginFormState> get copyWith =>
      _$LoginFormStateCopyWithImpl<LoginFormState>(
          this as LoginFormState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginFormState &&
            (identical(other.emailUsername, emailUsername) ||
                other.emailUsername == emailUsername) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isPasswordHidden, isPasswordHidden) ||
                other.isPasswordHidden == isPasswordHidden) &&
            (identical(other.emailUsernameError, emailUsernameError) ||
                other.emailUsernameError == emailUsernameError) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.generalError, generalError) ||
                other.generalError == generalError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      emailUsername,
      password,
      isPasswordHidden,
      emailUsernameError,
      passwordError,
      isLoading,
      generalError);

  @override
  String toString() {
    return 'LoginFormState(emailUsername: $emailUsername, password: $password, isPasswordHidden: $isPasswordHidden, emailUsernameError: $emailUsernameError, passwordError: $passwordError, isLoading: $isLoading, generalError: $generalError)';
  }
}

/// @nodoc
abstract mixin class $LoginFormStateCopyWith<$Res> {
  factory $LoginFormStateCopyWith(
          LoginFormState value, $Res Function(LoginFormState) _then) =
      _$LoginFormStateCopyWithImpl;
  @useResult
  $Res call(
      {String emailUsername,
      String password,
      bool isPasswordHidden,
      String? emailUsernameError,
      String? passwordError,
      bool isLoading,
      String? generalError});
}

/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._self, this._then);

  final LoginFormState _self;
  final $Res Function(LoginFormState) _then;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailUsername = null,
    Object? password = null,
    Object? isPasswordHidden = null,
    Object? emailUsernameError = freezed,
    Object? passwordError = freezed,
    Object? isLoading = null,
    Object? generalError = freezed,
  }) {
    return _then(_self.copyWith(
      emailUsername: null == emailUsername
          ? _self.emailUsername
          : emailUsername // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isPasswordHidden: null == isPasswordHidden
          ? _self.isPasswordHidden
          : isPasswordHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      emailUsernameError: freezed == emailUsernameError
          ? _self.emailUsernameError
          : emailUsernameError // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordError: freezed == passwordError
          ? _self.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      generalError: freezed == generalError
          ? _self.generalError
          : generalError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoginFormState].
extension LoginFormStatePatterns on LoginFormState {
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
    TResult Function(_LoginFormState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginFormState() when $default != null:
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
    TResult Function(_LoginFormState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginFormState():
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
    TResult? Function(_LoginFormState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginFormState() when $default != null:
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
            String emailUsername,
            String password,
            bool isPasswordHidden,
            String? emailUsernameError,
            String? passwordError,
            bool isLoading,
            String? generalError)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginFormState() when $default != null:
        return $default(
            _that.emailUsername,
            _that.password,
            _that.isPasswordHidden,
            _that.emailUsernameError,
            _that.passwordError,
            _that.isLoading,
            _that.generalError);
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
            String emailUsername,
            String password,
            bool isPasswordHidden,
            String? emailUsernameError,
            String? passwordError,
            bool isLoading,
            String? generalError)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginFormState():
        return $default(
            _that.emailUsername,
            _that.password,
            _that.isPasswordHidden,
            _that.emailUsernameError,
            _that.passwordError,
            _that.isLoading,
            _that.generalError);
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
            String emailUsername,
            String password,
            bool isPasswordHidden,
            String? emailUsernameError,
            String? passwordError,
            bool isLoading,
            String? generalError)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginFormState() when $default != null:
        return $default(
            _that.emailUsername,
            _that.password,
            _that.isPasswordHidden,
            _that.emailUsernameError,
            _that.passwordError,
            _that.isLoading,
            _that.generalError);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LoginFormState implements LoginFormState {
  const _LoginFormState(
      {this.emailUsername = '',
      this.password = '',
      this.isPasswordHidden = true,
      this.emailUsernameError,
      this.passwordError,
      this.isLoading = false,
      this.generalError});

  @override
  @JsonKey()
  final String emailUsername;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final bool isPasswordHidden;
  @override
  final String? emailUsernameError;
  @override
  final String? passwordError;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? generalError;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginFormStateCopyWith<_LoginFormState> get copyWith =>
      __$LoginFormStateCopyWithImpl<_LoginFormState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginFormState &&
            (identical(other.emailUsername, emailUsername) ||
                other.emailUsername == emailUsername) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isPasswordHidden, isPasswordHidden) ||
                other.isPasswordHidden == isPasswordHidden) &&
            (identical(other.emailUsernameError, emailUsernameError) ||
                other.emailUsernameError == emailUsernameError) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.generalError, generalError) ||
                other.generalError == generalError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      emailUsername,
      password,
      isPasswordHidden,
      emailUsernameError,
      passwordError,
      isLoading,
      generalError);

  @override
  String toString() {
    return 'LoginFormState(emailUsername: $emailUsername, password: $password, isPasswordHidden: $isPasswordHidden, emailUsernameError: $emailUsernameError, passwordError: $passwordError, isLoading: $isLoading, generalError: $generalError)';
  }
}

/// @nodoc
abstract mixin class _$LoginFormStateCopyWith<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  factory _$LoginFormStateCopyWith(
          _LoginFormState value, $Res Function(_LoginFormState) _then) =
      __$LoginFormStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String emailUsername,
      String password,
      bool isPasswordHidden,
      String? emailUsernameError,
      String? passwordError,
      bool isLoading,
      String? generalError});
}

/// @nodoc
class __$LoginFormStateCopyWithImpl<$Res>
    implements _$LoginFormStateCopyWith<$Res> {
  __$LoginFormStateCopyWithImpl(this._self, this._then);

  final _LoginFormState _self;
  final $Res Function(_LoginFormState) _then;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? emailUsername = null,
    Object? password = null,
    Object? isPasswordHidden = null,
    Object? emailUsernameError = freezed,
    Object? passwordError = freezed,
    Object? isLoading = null,
    Object? generalError = freezed,
  }) {
    return _then(_LoginFormState(
      emailUsername: null == emailUsername
          ? _self.emailUsername
          : emailUsername // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isPasswordHidden: null == isPasswordHidden
          ? _self.isPasswordHidden
          : isPasswordHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      emailUsernameError: freezed == emailUsernameError
          ? _self.emailUsernameError
          : emailUsernameError // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordError: freezed == passwordError
          ? _self.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      generalError: freezed == generalError
          ? _self.generalError
          : generalError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
