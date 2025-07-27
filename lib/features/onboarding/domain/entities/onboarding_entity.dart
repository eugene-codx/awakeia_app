import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_entity.freezed.dart';

/// Entity representing onboarding state
@freezed
abstract class OnboardingEntity with _$OnboardingEntity {
  const factory OnboardingEntity({
    required bool isCompleted,
    required DateTime? completedAt,
    required int currentStep,
    required Map<String, dynamic> preferences,
  }) = _OnboardingEntity;
}
