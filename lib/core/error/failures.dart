import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class for all application errors
/// Uses sealed classes for compile-time exhaustive pattern matching
@freezed
sealed class Failure with _$Failure {
  /// Server-related failures
  const factory Failure.server({
    @Default('Server error occurred') String message,
    @Default(500) int statusCode,
  }) = ServerFailure;

  /// Network connectivity failures
  const factory Failure.network({
    @Default('Network connection failed') String message,
  }) = NetworkFailure;

  /// Authentication failures
  const factory Failure.authentication({
    @Default('Authentication failed') String message,
  }) = AuthenticationFailure;

  /// Authorization failures
  const factory Failure.authorization({
    @Default('Access denied') String message,
  }) = AuthorizationFailure;

  /// Validation failures
  const factory Failure.validation({
    @Default('Validation failed') String message,
    @Default(<String, String>{}) Map<String, String> errors,
  }) = ValidationFailure;

  /// Cache failures
  const factory Failure.cache({
    @Default('Cache operation failed') String message,
  }) = CacheFailure;

  /// Unknown failures
  const factory Failure.unknown({
    @Default('Unknown error occurred') String message,
  }) = UnknownFailure;
}

/// Extension for convenient failure handling
extension FailureExtensions on Failure {
  /// Get user-friendly error message
  String get userMessage {
    return switch (this) {
      ServerFailure(message: final msg) => msg,
      NetworkFailure(message: final msg) => msg,
      AuthenticationFailure(message: final msg) => msg,
      AuthorizationFailure(message: final msg) => msg,
      ValidationFailure(message: final msg) => msg,
      CacheFailure(message: final msg) => msg,
      UnknownFailure(message: final msg) => msg,
    };
  }

  /// Check if failure is network-related
  bool get isNetworkFailure => this is NetworkFailure;

  /// Check if failure is authentication-related
  bool get isAuthFailure => this is AuthenticationFailure;

  /// Check if failure requires user re-authentication
  bool get requiresReauth {
    return switch (this) {
      AuthenticationFailure() => true,
      AuthorizationFailure() => true,
      _ => false,
    };
  }
}
