import 'package:dartz/dartz.dart';

import '../failures/onboarding_failure.dart';
import '../repositories/onboarding_repository.dart';

/// Use case for skipping onboarding (guest users)
class SkipOnboardingUseCase {
  SkipOnboardingUseCase({required OnboardingRepository repository})
      : _repository = repository;
  final OnboardingRepository _repository;

  Future<Either<OnboardingFailure, Unit>> call() async {
    return await _repository.skipOnboarding();
  }
}
