// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingModel _$OnboardingModelFromJson(Map<String, dynamic> json) =>
    _OnboardingModel(
      isCompleted: json['isCompleted'] as bool,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      currentStep: (json['currentStep'] as num?)?.toInt() ?? 0,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$OnboardingModelToJson(_OnboardingModel instance) =>
    <String, dynamic>{
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'currentStep': instance.currentStep,
      'preferences': instance.preferences,
    };
