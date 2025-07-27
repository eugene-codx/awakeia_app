import 'package:dartz/dartz.dart';

import '../entities/onboarding_entity.dart';
import '../failures/onboarding_failure.dart';
import '../repositories/onboarding_repository.dart';

/// Use case for getting onboarding state
class GetOnboardingStateUseCase {
  GetOnboardingStateUseCase({required OnboardingRepository repository})
      : _repository = repository;
  final OnboardingRepository _repository;

  Future<Either<OnboardingFailure, OnboardingEntity>> call() async {
    return await _repository.getOnboardingState();
  }
}
