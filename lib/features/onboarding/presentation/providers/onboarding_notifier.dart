import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../auth/auth.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/usecases/complete_onboarding_use_case.dart';
import '../../domain/usecases/get_onboarding_state_use_case.dart';
import '../../domain/usecases/skip_onboarding_use_case.dart';
import 'onboarding_providers.dart';
import 'onboarding_state.dart';

/// Notifier for managing onboarding state
class OnboardingNotifier extends AsyncNotifier<OnboardingState> {
  late final GetOnboardingStateUseCase _getOnboardingStateUseCase;
  late final CompleteOnboardingUseCase _completeOnboardingUseCase;
  late final SkipOnboardingUseCase _skipOnboardingUseCase;

  StreamSubscription<AsyncValue<dynamic>>? _authSubscription;

  @override
  Future<OnboardingState> build() async {
    // Initialize dependencies
    _getOnboardingStateUseCase = ref.watch(getOnboardingStateUseCaseProvider);
    _completeOnboardingUseCase = ref.watch(completeOnboardingUseCaseProvider);
    _skipOnboardingUseCase = ref.watch(skipOnboardingUseCaseProvider);

    AppLogger.info('OnboardingNotifier: Initializing');

    // Clean up subscription on dispose
    ref.onDispose(() {
      AppLogger.info('OnboardingNotifier: Disposing');
      _authSubscription?.cancel();
    });

    // Listen to auth state changes
    _authSubscription = ref.listen(authNotifierProvider, (previous, next) {
      _handleAuthStateChange(next);
    }) as StreamSubscription<AsyncValue>?;

    // Get initial state
    return await _loadInitialState();
  }

  Future<OnboardingState> _loadInitialState() async {
    try {
      // Get onboarding state
      final onboardingResult = await _getOnboardingStateUseCase();

      return onboardingResult.fold(
        (failure) => OnboardingState.error(failure.toMessage()),
        (onboarding) {
          // Check auth state
          final authState = ref.read(authNotifierProvider);

          return authState.maybeWhen(
            data: (authStateData) => authStateData.when(
              authenticated: (user) => OnboardingState.authenticated(
                user: user,
                onboarding: onboarding,
              ),
              unauthenticated: (_) => OnboardingState.unauthenticated(
                onboarding: onboarding,
              ),
              initial: () => OnboardingState.unauthenticated(
                onboarding: onboarding,
              ),
              loading: () => const OnboardingState.loading(),
            ),
            orElse: () => OnboardingState.unauthenticated(
              onboarding: onboarding,
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load initial onboarding state', e, stackTrace);
      return OnboardingState.error(e.toString());
    }
  }

  void _handleAuthStateChange(AsyncValue<dynamic> authState) {
    authState.whenData((authStateData) async {
      final currentState = state.valueOrNull;
      if (currentState == null) return;

      // Reload onboarding state with new auth state
      state = await AsyncValue.guard(() => _loadInitialState());
    });
  }

  /// Complete onboarding and continue as guest
  Future<void> continueAsGuest() async {
    state = const AsyncValue.loading();

    try {
      // First sign in as guest
      final signInAsGuest = ref.read(signInAsGuestActionProvider);
      await signInAsGuest();

      // Then skip onboarding
      final skipResult = await _skipOnboardingUseCase();

      skipResult.fold(
        (failure) {
          state = AsyncValue.data(OnboardingState.error(failure.toMessage()));
        },
        (_) {
          AppLogger.info('Successfully continued as guest');
          // State will be updated by auth state listener
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to continue as guest', e, stackTrace);
      state = AsyncValue.data(OnboardingState.error(e.toString()));
    }
  }

  /// Complete onboarding for authenticated user
  Future<void> completeOnboarding() async {
    state = const AsyncValue.loading();

    try {
      final result = await _completeOnboardingUseCase();

      result.fold(
        (failure) {
          state = AsyncValue.data(OnboardingState.error(failure.toMessage()));
        },
        (_) async {
          AppLogger.info('Onboarding completed successfully');
          // Reload state
          state = await AsyncValue.guard(() => _loadInitialState());
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to complete onboarding', e, stackTrace);
      state = AsyncValue.data(OnboardingState.error(e.toString()));
    }
  }
}
