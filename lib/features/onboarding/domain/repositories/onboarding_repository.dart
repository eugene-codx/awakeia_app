import 'package:dartz/dartz.dart';

import '../entities/onboarding_entity.dart';
import '../failures/onboarding_failure.dart';

/// Repository interface for onboarding operations
abstract class OnboardingRepository {
  /// Get onboarding state
  Future<Either<OnboardingFailure, OnboardingEntity>> getOnboardingState();

  /// Mark onboarding as completed
  Future<Either<OnboardingFailure, Unit>> completeOnboarding();

  /// Update onboarding progress
  Future<Either<OnboardingFailure, Unit>> updateProgress({
    required int step,
    Map<String, dynamic>? preferences,
  });

  /// Skip onboarding (for guest users)
  Future<Either<OnboardingFailure, Unit>> skipOnboarding();
}
