import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/user_entity.dart';
import '../failures/auth_failure.dart';
import '../repositories/auth_repository.dart';

/// Use case for user login with email and password
class LoginUseCase {
  LoginUseCase({
    required AuthRepository repository,
  }) : _repository = repository;
  final AuthRepository _repository;

  /// Execute the login use case
  Future<Either<AuthFailure, UserEntity>> call(LoginParams params) async {
    return await _repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for login use case
class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
