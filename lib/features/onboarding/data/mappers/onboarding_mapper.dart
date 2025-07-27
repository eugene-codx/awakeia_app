import '../../domain/entities/onboarding_entity.dart';
import '../models/onboarding_model.dart';

/// Mapper for converting between OnboardingModel and OnboardingEntity
class OnboardingMapper {
  /// Convert model to entity
  static OnboardingEntity toEntity(OnboardingModel model) {
    return OnboardingEntity(
      isCompleted: model.isCompleted,
      completedAt: model.completedAt,
      currentStep: model.currentStep,
      preferences: model.preferences,
    );
  }

  /// Convert entity to model
  static OnboardingModel toModel(OnboardingEntity entity) {
    return OnboardingModel(
      isCompleted: entity.isCompleted,
      completedAt: entity.completedAt,
      currentStep: entity.currentStep,
      preferences: entity.preferences,
    );
  }
}
