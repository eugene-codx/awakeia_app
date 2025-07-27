import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/onboarding_entity.dart';

part 'onboarding_state.freezed.dart';

/// State for onboarding screen
@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial() = _Initial;
  const factory OnboardingState.loading() = _Loading;
  const factory OnboardingState.authenticated({
    required UserEntity user,
    required OnboardingEntity onboarding,
  }) = _Authenticated;
  const factory OnboardingState.unauthenticated({
    required OnboardingEntity onboarding,
  }) = _Unauthenticated;
  const factory OnboardingState.error(String message) = _Error;
}
