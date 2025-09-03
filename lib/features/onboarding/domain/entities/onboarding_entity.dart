/// Entity representing onboarding state
class OnboardingEntity {
  // фиксируем общее число шагов

  const OnboardingEntity({required this.currentStep, required this.totalSteps});

  factory OnboardingEntity.fromJson(Map<String, dynamic> json) =>
      OnboardingEntity(
        currentStep: (json['currentStep'] as num?)?.toInt() ?? 0,
        totalSteps: (json['totalSteps'] as num?)?.toInt() ?? 3,
      );
  final int currentStep; // 0..(totalSteps-1)
  final int totalSteps;

  bool get isCompleted => currentStep >= totalSteps;

  OnboardingEntity next() => isCompleted
      ? this
      : OnboardingEntity(currentStep: currentStep + 1, totalSteps: totalSteps);

  Map<String, dynamic> toJson() => {
        'currentStep': currentStep,
        'totalSteps': totalSteps,
      };
}
