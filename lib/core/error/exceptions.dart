/// Base exception class for all application exceptions
abstract class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => 'AppException: $message';
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException(super.message, {this.statusCode = 500});

  final int statusCode;

  @override
  String toString() => 'ServerException($statusCode): $message';
}

/// Network connectivity exceptions
class NetworkException extends AppException {
  const NetworkException(super.message);

  @override
  String toString() => 'NetworkException: $message';
}

/// Authentication exceptions
class AuthenticationException extends AppException {
  const AuthenticationException(super.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Authorization exceptions
class AuthorizationException extends AppException {
  const AuthorizationException(super.message);

  @override
  String toString() => 'AuthorizationException: $message';
}

/// Validation exceptions
class ValidationException extends AppException {
  const ValidationException(super.message, {this.errors = const {}});

  final Map<String, String> errors;

  @override
  String toString() =>
      'ValidationException: $message${errors.isNotEmpty ? ' - Errors: $errors' : ''}';
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException(super.message);

  @override
  String toString() => 'CacheException: $message';
}

/// Unknown exceptions
class UnknownException extends AppException {
  const UnknownException(super.message);

  @override
  String toString() => 'UnknownException: $message';
}
