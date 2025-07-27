import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_model.freezed.dart';
part 'onboarding_model.g.dart';

/// Data model for onboarding state
@freezed
abstract class OnboardingModel with _$OnboardingModel {
  const factory OnboardingModel({
    required bool isCompleted,
    DateTime? completedAt,
    @Default(0) int currentStep,
    @Default({}) Map<String, dynamic> preferences,
  }) = _OnboardingModel;

  const OnboardingModel._();

  factory OnboardingModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingModelFromJson(json);
}
