import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

/// Represents all possible authentication failures
/// Used in the domain layer to handle errors in a type-safe way
@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.serverError([String? message]) = _ServerError;
  const factory AuthFailure.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      _InvalidEmailAndPasswordCombination;
  const factory AuthFailure.invalidEmail() = _InvalidEmail;
  const factory AuthFailure.weakPassword() = _WeakPassword;
  const factory AuthFailure.userNotFound() = _UserNotFound;
  const factory AuthFailure.userDisabled() = _UserDisabled;
  const factory AuthFailure.tooManyRequests() = _TooManyRequests;
  const factory AuthFailure.operationNotAllowed() = _OperationNotAllowed;
  const factory AuthFailure.networkError() = _NetworkError;
  const factory AuthFailure.unexpectedError([String? message]) =
      _UnexpectedError;
  const factory AuthFailure.storageError() = _StorageError;
  const factory AuthFailure.tokenExpired() = _TokenExpired;
  const factory AuthFailure.noAuthToken() = _NoAuthToken;

  const AuthFailure._();

  /// Convert failure to user-friendly message
  String toMessage() {
    return when(
      serverError: (message) =>
          message ?? 'Server error occurred. Please try again.',
      emailAlreadyInUse: () => 'This email is already registered.',
      invalidEmailAndPasswordCombination: () => 'Invalid email or password.',
      invalidEmail: () => 'Please enter a valid email address.',
      weakPassword: () => 'Password must be at least 6 characters long.',
      userNotFound: () => 'No user found with this email.',
      userDisabled: () => 'This account has been disabled.',
      tooManyRequests: () => 'Too many attempts. Please try again later.',
      operationNotAllowed: () => 'This operation is not allowed.',
      networkError: () => 'No internet connection. Please check your network.',
      unexpectedError: (message) => message ?? 'An unexpected error occurred.',
      storageError: () => 'Failed to save data locally.',
      tokenExpired: () => 'Your session has expired. Please sign in again.',
      noAuthToken: () => 'Authentication required. Please sign in.',
    );
  }
}
