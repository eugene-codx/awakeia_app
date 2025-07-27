import 'package:dartz/dartz.dart';
import 'package:talker/talker.dart';

import '../../domain/entities/onboarding_entity.dart';
import '../../domain/failures/onboarding_failure.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';
import '../mappers/onboarding_mapper.dart';
import '../models/onboarding_model.dart';

/// Implementation of OnboardingRepository
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl({
    required OnboardingLocalDataSource localDataSource,
    required Talker talker,
  })  : _localDataSource = localDataSource,
        _talker = talker;
  final OnboardingLocalDataSource _localDataSource;
  final Talker _talker;

  @override
  Future<Either<OnboardingFailure, OnboardingEntity>>
      getOnboardingState() async {
    try {
      _talker.info('Getting onboarding state');

      final model = await _localDataSource.getOnboardingState();

      if (model == null) {
        // Return default state if not found
        const defaultEntity = OnboardingEntity(
          isCompleted: false,
          completedAt: null,
          currentStep: 0,
          preferences: {},
        );
        return const Right(defaultEntity);
      }

      final entity = OnboardingMapper.toEntity(model);
      return Right(entity);
    } catch (e, stackTrace) {
      _talker.error('Failed to get onboarding state', e, stackTrace);
      return Left(OnboardingFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<OnboardingFailure, Unit>> completeOnboarding() async {
    try {
      _talker.info('Completing onboarding');

      final model = OnboardingModel(
        isCompleted: true,
        completedAt: DateTime.now(),
        currentStep: -1, // -1 indicates completed
        preferences: {},
      );

      await _localDataSource.saveOnboardingState(model);

      _talker.info('Onboarding completed successfully');
      return const Right(unit);
    } catch (e, stackTrace) {
      _talker.error('Failed to complete onboarding', e, stackTrace);
      return Left(OnboardingFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<OnboardingFailure, Unit>> updateProgress({
    required int step,
    Map<String, dynamic>? preferences,
  }) async {
    try {
      _talker.info('Updating onboarding progress to step $step');

      // Get current state
      final currentModel = await _localDataSource.getOnboardingState();

      final updatedModel = OnboardingModel(
        isCompleted: false,
        completedAt: null,
        currentStep: step,
        preferences: preferences ?? currentModel?.preferences ?? {},
      );

      await _localDataSource.saveOnboardingState(updatedModel);

      return const Right(unit);
    } catch (e, stackTrace) {
      _talker.error('Failed to update onboarding progress', e, stackTrace);
      return Left(OnboardingFailure.unexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<OnboardingFailure, Unit>> skipOnboarding() async {
    try {
      _talker.info('Skipping onboarding');

      final model = OnboardingModel(
        isCompleted: true,
        completedAt: DateTime.now(),
        currentStep: -1,
        preferences: {'skipped': true},
      );

      await _localDataSource.saveOnboardingState(model);

      _talker.info('Onboarding skipped successfully');
      return const Right(unit);
    } catch (e, stackTrace) {
      _talker.error('Failed to skip onboarding', e, stackTrace);
      return Left(OnboardingFailure.unexpectedError(e.toString()));
    }
  }
}
