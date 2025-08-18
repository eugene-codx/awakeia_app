// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingModel _$OnboardingModelFromJson(Map<String, dynamic> json) =>
    _OnboardingModel(
      isCompleted: json['is_completed'] as bool,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      currentStep: (json['current_step'] as num?)?.toInt() ?? 0,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$OnboardingModelToJson(_OnboardingModel instance) =>
    <String, dynamic>{
      'is_completed': instance.isCompleted,
      'completed_at': instance.completedAt?.toIso8601String(),
      'current_step': instance.currentStep,
      'preferences': instance.preferences,
    };
