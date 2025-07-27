// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingEntity {
  bool get isCompleted;
  DateTime? get completedAt;
  int get currentStep;
  Map<String, dynamic> get preferences;

  /// Create a copy of OnboardingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OnboardingEntityCopyWith<OnboardingEntity> get copyWith =>
      _$OnboardingEntityCopyWithImpl<OnboardingEntity>(
          this as OnboardingEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OnboardingEntity &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            const DeepCollectionEquality()
                .equals(other.preferences, preferences));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCompleted, completedAt,
      currentStep, const DeepCollectionEquality().hash(preferences));

  @override
  String toString() {
    return 'OnboardingEntity(isCompleted: $isCompleted, completedAt: $completedAt, currentStep: $currentStep, preferences: $preferences)';
  }
}

/// @nodoc
abstract mixin class $OnboardingEntityCopyWith<$Res> {
  factory $OnboardingEntityCopyWith(
          OnboardingEntity value, $Res Function(OnboardingEntity) _then) =
      _$OnboardingEntityCopyWithImpl;
  @useResult
  $Res call(
      {bool isCompleted,
      DateTime? completedAt,
      int currentStep,
      Map<String, dynamic> preferences});
}

/// @nodoc
class _$OnboardingEntityCopyWithImpl<$Res>
    implements $OnboardingEntityCopyWith<$Res> {
  _$OnboardingEntityCopyWithImpl(this._self, this._then);

  final OnboardingEntity _self;
  final $Res Function(OnboardingEntity) _then;

  /// Create a copy of OnboardingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? currentStep = null,
    Object? preferences = null,
  }) {
    return _then(_self.copyWith(
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      preferences: null == preferences
          ? _self.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// Adds pattern-matching-related methods to [OnboardingEntity].
extension OnboardingEntityPatterns on OnboardingEntity {
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
    TResult Function(_OnboardingEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OnboardingEntity() when $default != null:
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
    TResult Function(_OnboardingEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingEntity():
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
    TResult? Function(_OnboardingEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingEntity() when $default != null:
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
    TResult Function(bool isCompleted, DateTime? completedAt, int currentStep,
            Map<String, dynamic> preferences)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OnboardingEntity() when $default != null:
        return $default(_that.isCompleted, _that.completedAt, _that.currentStep,
            _that.preferences);
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
    TResult Function(bool isCompleted, DateTime? completedAt, int currentStep,
            Map<String, dynamic> preferences)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingEntity():
        return $default(_that.isCompleted, _that.completedAt, _that.currentStep,
            _that.preferences);
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
    TResult? Function(bool isCompleted, DateTime? completedAt, int currentStep,
            Map<String, dynamic> preferences)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingEntity() when $default != null:
        return $default(_that.isCompleted, _that.completedAt, _that.currentStep,
            _that.preferences);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OnboardingEntity implements OnboardingEntity {
  const _OnboardingEntity(
      {required this.isCompleted,
      required this.completedAt,
      required this.currentStep,
      required final Map<String, dynamic> preferences})
      : _preferences = preferences;

  @override
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final int currentStep;
  final Map<String, dynamic> _preferences;
  @override
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  /// Create a copy of OnboardingEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OnboardingEntityCopyWith<_OnboardingEntity> get copyWith =>
      __$OnboardingEntityCopyWithImpl<_OnboardingEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OnboardingEntity &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCompleted, completedAt,
      currentStep, const DeepCollectionEquality().hash(_preferences));

  @override
  String toString() {
    return 'OnboardingEntity(isCompleted: $isCompleted, completedAt: $completedAt, currentStep: $currentStep, preferences: $preferences)';
  }
}

/// @nodoc
abstract mixin class _$OnboardingEntityCopyWith<$Res>
    implements $OnboardingEntityCopyWith<$Res> {
  factory _$OnboardingEntityCopyWith(
          _OnboardingEntity value, $Res Function(_OnboardingEntity) _then) =
      __$OnboardingEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isCompleted,
      DateTime? completedAt,
      int currentStep,
      Map<String, dynamic> preferences});
}

/// @nodoc
class __$OnboardingEntityCopyWithImpl<$Res>
    implements _$OnboardingEntityCopyWith<$Res> {
  __$OnboardingEntityCopyWithImpl(this._self, this._then);

  final _OnboardingEntity _self;
  final $Res Function(_OnboardingEntity) _then;

  /// Create a copy of OnboardingEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? currentStep = null,
    Object? preferences = null,
  }) {
    return _then(_OnboardingEntity(
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      preferences: null == preferences
          ? _self._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
