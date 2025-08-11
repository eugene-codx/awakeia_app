// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_form_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterFormState {
  String get email;
  String get password;
  String get confirmPassword;
  bool get isPasswordHidden;
  bool get isConfirmPasswordHidden;
  String? get emailError;
  String? get passwordError;
  String? get confirmPasswordError;
  bool get isLoading;
  String? get generalError;
  bool get agreedToTerms;

  /// Create a copy of RegisterFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegisterFormStateCopyWith<RegisterFormState> get copyWith =>
      _$RegisterFormStateCopyWithImpl<RegisterFormState>(
          this as RegisterFormState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegisterFormState &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.isPasswordHidden, isPasswordHidden) ||
                other.isPasswordHidden == isPasswordHidden) &&
            (identical(
                    other.isConfirmPasswordHidden, isConfirmPasswordHidden) ||
                other.isConfirmPasswordHidden == isConfirmPasswordHidden) &&
            (identical(other.emailError, emailError) ||
                other.emailError == emailError) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.confirmPasswordError, confirmPasswordError) ||
                other.confirmPasswordError == confirmPasswordError) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.generalError, generalError) ||
                other.generalError == generalError) &&
            (identical(other.agreedToTerms, agreedToTerms) ||
                other.agreedToTerms == agreedToTerms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      password,
      confirmPassword,
      isPasswordHidden,
      isConfirmPasswordHidden,
      emailError,
      passwordError,
      confirmPasswordError,
      isLoading,
      generalError,
      agreedToTerms);

  @override
  String toString() {
    return 'RegisterFormState(email: $email, password: $password, confirmPassword: $confirmPassword, isPasswordHidden: $isPasswordHidden, isConfirmPasswordHidden: $isConfirmPasswordHidden, emailError: $emailError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, isLoading: $isLoading, generalError: $generalError, agreedToTerms: $agreedToTerms)';
  }
}

/// @nodoc
abstract mixin class $RegisterFormStateCopyWith<$Res> {
  factory $RegisterFormStateCopyWith(
          RegisterFormState value, $Res Function(RegisterFormState) _then) =
      _$RegisterFormStateCopyWithImpl;
  @useResult
  $Res call(
      {String email,
      String password,
      String confirmPassword,
      bool isPasswordHidden,
      bool isConfirmPasswordHidden,
      String? emailError,
      String? passwordError,
      String? confirmPasswordError,
      bool isLoading,
      String? generalError,
      bool agreedToTerms});
}

/// @nodoc
class _$RegisterFormStateCopyWithImpl<$Res>
    implements $RegisterFormStateCopyWith<$Res> {
  _$RegisterFormStateCopyWithImpl(this._self, this._then);

  final RegisterFormState _self;
  final $Res Function(RegisterFormState) _then;

  /// Create a copy of RegisterFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? isPasswordHidden = null,
    Object? isConfirmPasswordHidden = null,
    Object? emailError = freezed,
    Object? passwordError = freezed,
    Object? confirmPasswordError = freezed,
    Object? isLoading = null,
    Object? generalError = freezed,
    Object? agreedToTerms = null,
  }) {
    return _then(_self.copyWith(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _self.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      isPasswordHidden: null == isPasswordHidden
          ? _self.isPasswordHidden
          : isPasswordHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      isConfirmPasswordHidden: null == isConfirmPasswordHidden
          ? _self.isConfirmPasswordHidden
          : isConfirmPasswordHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      emailError: freezed == emailError
          ? _self.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordError: freezed == passwordError
          ? _self.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPasswordError: freezed == confirmPasswordError
          ? _self.confirmPasswordError
          : confirmPasswordError // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      generalError: freezed == generalError
          ? _self.generalError
          : generalError // ignore: cast_nullable_to_non_nullable
              as String?,
      agreedToTerms: null == agreedToTerms
          ? _self.agreedToTerms
          : agreedToTerms // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [RegisterFormState].
extension RegisterFormStatePatterns on RegisterFormState {
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
    TResult Function(_RegisterFormState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState() when $default != null:
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
    TResult Function(_RegisterFormState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState():
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
    TResult? Function(_RegisterFormState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState() when $default != null:
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
            String email,
            String password,
            String confirmPassword,
            bool isPasswordHidden,
            bool isConfirmPasswordHidden,
            String? emailError,
            String? passwordError,
            String? confirmPasswordError,
            bool isLoading,
            String? generalError,
            bool agreedToTerms)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState() when $default != null:
        return $default(
            _that.email,
            _that.password,
            _that.confirmPassword,
            _that.isPasswordHidden,
            _that.isConfirmPasswordHidden,
            _that.emailError,
            _that.passwordError,
            _that.confirmPasswordError,
            _that.isLoading,
            _that.generalError,
            _that.agreedToTerms);
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
            String email,
            String password,
            String confirmPassword,
            bool isPasswordHidden,
            bool isConfirmPasswordHidden,
            String? emailError,
            String? passwordError,
            String? confirmPasswordError,
            bool isLoading,
            String? generalError,
            bool agreedToTerms)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState():
        return $default(
            _that.email,
            _that.password,
            _that.confirmPassword,
            _that.isPasswordHidden,
            _that.isConfirmPasswordHidden,
            _that.emailError,
            _that.passwordError,
            _that.confirmPasswordError,
            _that.isLoading,
            _that.generalError,
            _that.agreedToTerms);
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
            String email,
            String password,
            String confirmPassword,
            bool isPasswordHidden,
            bool isConfirmPasswordHidden,
            String? emailError,
            String? passwordError,
            String? confirmPasswordError,
            bool isLoading,
            String? generalError,
            bool agreedToTerms)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegisterFormState() when $default != null:
        return $default(
            _that.email,
            _that.password,
            _that.confirmPassword,
            _that.isPasswordHidden,
            _that.isConfirmPasswordHidden,
            _that.emailError,
            _that.passwordError,
            _that.confirmPasswordError,
            _that.isLoading,
            _that.generalError,
            _that.agreedToTerms);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RegisterFormState implements RegisterFormState {
  const _RegisterFormState(
      {this.email = '',
      this.password = '',
      this.confirmPassword = '',
      this.isPasswordHidden = true,
      this.isConfirmPasswordHidden = true,
      this.emailError,
      this.passwordError,
      this.confirmPasswordError,
      this.isLoading = false,
      this.generalError,
      this.agreedToTerms = false});

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String confirmPassword;
  @override
  @JsonKey()
  final bool isPasswordHidden;
  @override
  @JsonKey()
  final bool isConfirmPasswordHidden;
  @override
  final String? emailError;
  @override
  final String? passwordError;
  @override
  final String? confirmPasswordError;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? generalError;
  @override
  @JsonKey()
  final bool agreedToTerms;

  /// Create a copy of RegisterFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegisterFormStateCopyWith<_RegisterFormState> get copyWith =>
      __$RegisterFormStateCopyWithImpl<_RegisterFormState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterFormState &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.isPasswordHidden, isPasswordHidden) ||
                other.isPasswordHidden == isPasswordHidden) &&
            (identical(
                    other.isConfirmPasswordHidden, isConfirmPasswordHidden) ||
                other.isConfirmPasswordHidden == isConfirmPasswordHidden) &&
            (identical(other.emailError, emailError) ||
                other.emailError == emailError) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.confirmPasswordError, confirmPasswordError) ||
                other.confirmPasswordError == confirmPasswordError) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.generalError, generalError) ||
                other.generalError == generalError) &&
            (identical(other.agreedToTerms, agreedToTerms) ||
                other.agreedToTerms == agreedToTerms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      password,
      confirmPassword,
      isPasswordHidden,
      isConfirmPasswordHidden,
      emailError,
      passwordError,
      confirmPasswordError,
      isLoading,
      generalError,
      agreedToTerms);

  @override
  String toString() {
    return 'RegisterFormState(email: $email, password: $password, confirmPassword: $confirmPassword, isPasswordHidden: $isPasswordHidden, isConfirmPasswordHidden: $isConfirmPasswordHidden, emailError: $emailError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, isLoading: $isLoading, generalError: $generalError, agreedToTerms: $agreedToTerms)';
  }
}

/// @nodoc
abstract mixin class _$RegisterFormStateCopyWith<$Res>
    implements $RegisterFormStateCopyWith<$Res> {
  factory _$RegisterFormStateCopyWith(
          _RegisterFormState value, $Res Function(_RegisterFormState) _then) =
      __$RegisterFormStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      String confirmPassword,
      bool isPasswordHidden,
      bool isConfirmPasswordHidden,
      String? emailError,
      String? passwordError,
      String? confirmPasswordError,
      bool isLoading,
      String? generalError,
      bool agreedToTerms});
}

/// @nodoc
class __$RegisterFormStateCopyWithImpl<$Res>
    implements _$RegisterFormStateCopyWith<$Res> {
  __$RegisterFormStateCopyWithImpl(this._self, this._then);

  final _RegisterFormState _self;
  final $Res Function(_RegisterFormState) _then;

  /// Create a copy of RegisterFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? isPasswordHidden = null,
    Object? isConfirmPasswordHidden = null,
    Object? emailError = freezed,
    Object? passwordError = freezed,
    Object? confirmPasswordError = freezed,
    Object? isLoading = null,
    Object? generalError = freezed,
    Object? agreedToTerms = null,
  }) {
    return _then(_RegisterFormState(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _self.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      isPasswordHidden: null == isPasswordHidden
          ? _self.isPasswordHidden
          : isPasswordHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      isConfirmPasswordHidden: null == isConfirmPasswordHidden
          ? _self.isConfirmPasswordHidden
          : isConfirmPasswordHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      emailError: freezed == emailError
          ? _self.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordError: freezed == passwordError
          ? _self.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPasswordError: freezed == confirmPasswordError
          ? _self.confirmPasswordError
          : confirmPasswordError // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      generalError: freezed == generalError
          ? _self.generalError
          : generalError // ignore: cast_nullable_to_non_nullable
              as String?,
      agreedToTerms: null == agreedToTerms
          ? _self.agreedToTerms
          : agreedToTerms // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
