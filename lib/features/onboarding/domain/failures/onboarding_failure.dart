import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_failure.freezed.dart';

/// Failures that can occur in onboarding feature
@freezed
abstract class OnboardingFailure with _$OnboardingFailure {
  const factory OnboardingFailure.storageError() = StorageError;
  const factory OnboardingFailure.invalidState() = InvalidState;
  const factory OnboardingFailure.unexpectedError(String message) =
      UnexpectedError;

  const OnboardingFailure._();

  /// Convert failure to user-friendly message
  String toMessage() {
    return when(
      storageError: () => 'Failed to save onboarding progress',
      invalidState: () => 'Invalid onboarding state',
      unexpectedError: (message) => 'Something went wrong: $message',
    );
  }
}
