import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/failures/auth_failure.dart';

part 'auth_state.freezed.dart';

/// Represents the authentication state of the application
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthState.unauthenticated([AuthFailure? failure]) =
      _Unauthenticated;

  const AuthState._();

  /// Convenience getters for checking state
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isAuthenticated => this is _Authenticated;
  bool get isUnauthenticated => this is _Unauthenticated;

  /// Get current user if authenticated
  UserEntity? get user => whenOrNull(
        authenticated: (user) => user,
      );

  /// Get error message if any
  String? get errorMessage => whenOrNull(
        unauthenticated: (failure) => failure?.toMessage(),
      );
}
