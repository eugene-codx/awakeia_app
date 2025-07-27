import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import 'onboarding_notifier.dart';
import 'onboarding_state.dart';

// ===== Data Sources Providers =====

/// Provider for onboarding local data source
final onboardingLocalDataSourceProvider =
    Provider<OnboardingLocalDataSource>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return OnboardingLocalDataSourceImpl(secureStorage: secureStorage);
});

// ===== Repository Provider =====

/// Provider for onboarding repository
final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final localDataSource = ref.watch(onboardingLocalDataSourceProvider);
  final talker = ref.watch(talkerProvider);

  return OnboardingRepositoryImpl(
    localDataSource: localDataSource,
    talker: talker,
  );
});

// ===== Use Cases Providers =====

/// Provider for get onboarding state use case
final getOnboardingStateUseCaseProvider =
    Provider<GetOnboardingStateUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return GetOnboardingStateUseCase(repository: repository);
});

/// Provider for complete onboarding use case
final completeOnboardingUseCaseProvider =
    Provider<CompleteOnboardingUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return CompleteOnboardingUseCase(repository: repository);
});

/// Provider for skip onboarding use case
final skipOnboardingUseCaseProvider = Provider<SkipOnboardingUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return SkipOnboardingUseCase(repository: repository);
});

// ===== State Management =====

/// Main onboarding notifier provider
final onboardingNotifierProvider =
    AsyncNotifierProvider<OnboardingNotifier, OnboardingState>(() {
  return OnboardingNotifier();
});

// ===== Convenience Providers =====

/// Provider to check if onboarding is loading
final onboardingLoadingProvider = Provider<bool>((ref) {
  return ref.watch(onboardingNotifierProvider).isLoading;
});

/// Provider to check if user is authenticated on onboarding screen
final onboardingAuthenticatedProvider = Provider<bool>((ref) {
  final state = ref.watch(onboardingNotifierProvider);
  return state.maybeWhen(
    data: (data) => data.maybeWhen(
      authenticated: (_, __) => true,
      orElse: () => false,
    ),
    orElse: () => false,
  );
});

/// Provider to get current onboarding entity
final currentOnboardingProvider = Provider<OnboardingEntity?>((ref) {
  final state = ref.watch(onboardingNotifierProvider);
  return state.maybeWhen(
    data: (data) => data.maybeWhen(
      authenticated: (_, onboarding) => onboarding,
      unauthenticated: (onboarding) => onboarding,
      orElse: () => null,
    ),
    orElse: () => null,
  );
});

// ===== Action Providers =====

/// Action to continue as guest
final continueAsGuestActionProvider = Provider((ref) {
  return () async {
    await ref.read(onboardingNotifierProvider.notifier).continueAsGuest();
  };
});

/// Action to complete onboarding
final completeOnboardingActionProvider = Provider((ref) {
  return () async {
    await ref.read(onboardingNotifierProvider.notifier).completeOnboarding();
  };
});
