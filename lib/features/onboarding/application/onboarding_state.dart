import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/onboarding_entity.dart';

part 'onboarding_state.freezed.dart';

/// State for onboarding screen
@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.loading() = _Loading;

  const factory OnboardingState.onboarding(
    OnboardingEntity onboarding,
  ) = _Onboarding;

  const factory OnboardingState.firstScreen() = _FirstScreen;

  const factory OnboardingState.error(String message) = _Error;
}
