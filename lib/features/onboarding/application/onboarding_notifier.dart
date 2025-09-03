import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../auth/presentation/providers/auth_providers.dart';
import '../data/repositories/onboarding_repository.dart';
import '../domain/entities/onboarding_entity.dart';
import 'onboarding_state.dart';

const kOnboardingTotalSteps = 3;

final onboardingNotifierProvider =
    AsyncNotifierProvider<OnboardingNotifier, OnboardingState>(
  OnboardingNotifier.new,
);

final continueAsGuestActionProvider = Provider((ref) {
  return () async {
    await ref.read(onboardingNotifierProvider.notifier).continueAsGuest();
  };
});

/// Notifier for managing onboarding state
class OnboardingNotifier extends AsyncNotifier<OnboardingState> {
  late final OnboardingRepository _repo;

  @override
  Future<OnboardingState> build() async {
    AppLogger.info('OnboardingNotifier: Initializing');
    _repo = ref.watch(onboardingRepositoryProvider);
    final entity =
        await _repo.getState(defaultTotalSteps: kOnboardingTotalSteps);

    if (entity.isCompleted) {
      return const OnboardingState.firstScreen();
    } else {
      // if totalSteps is different, adjust it and save
      if (entity.totalSteps != kOnboardingTotalSteps) {
        final adjusted = OnboardingEntity(
          currentStep: entity.currentStep.clamp(0, kOnboardingTotalSteps),
          totalSteps: kOnboardingTotalSteps,
        );
        await _repo.saveState(adjusted);
        return OnboardingState.onboarding(adjusted);
      }
      return OnboardingState.onboarding(entity);
    }
  }

  Future<void> nextStep() async {
    final st = state.valueOrNull;
    if (st == null) return;

    await st.maybeWhen(
      onboarding: (entity) async {
        final next = entity.next();

        if (next.isCompleted) {
          await _repo.markCompleted(totalSteps: kOnboardingTotalSteps);
          state = const AsyncValue.data(OnboardingState.firstScreen());
        } else {
          await _repo.saveState(next);
          state = AsyncValue.data(OnboardingState.onboarding(next));
        }
      },
      orElse: () async {},
    );
  }

  Future<void> skip() async {
    await _repo.markCompleted(totalSteps: kOnboardingTotalSteps);
    state = const AsyncValue.data(OnboardingState.firstScreen());
  }

  Future<void> reset() async {
    await _repo.reset();
    state = const AsyncValue.data(
      OnboardingState.onboarding(
        OnboardingEntity(currentStep: 0, totalSteps: kOnboardingTotalSteps),
      ),
    );
  }

  /// Continue as guest
  Future<void> continueAsGuest() async {
    state = const AsyncValue.loading();

    try {
      // First sign in as guest
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.signInAsGuest();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to continue as guest', e, stackTrace);
      state = AsyncValue.data(OnboardingState.error(e.toString()));
    }
  }
}
