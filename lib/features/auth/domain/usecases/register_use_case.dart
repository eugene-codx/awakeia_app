import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/user_entity.dart';
import '../failures/auth_failure.dart';
import '../repositories/auth_repository.dart';

/// Use case for user registration with email and password
class RegisterUseCase {
  RegisterUseCase({
    required AuthRepository repository,
  }) : _repository = repository;
  final AuthRepository _repository;

  /// Execute the registration use case
  Future<Either<AuthFailure, UserEntity>> call(RegisterParams params) async {
    return await _repository.registerWithEmailAndPassword(
      email: params.email,
      password: params.password,
      username: params.username,
      firstName: params.firstName,
    );
  }
}

/// Parameters for registration use case
class RegisterParams extends Equatable {
  const RegisterParams({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
  });
  final String email;
  final String password;
  final String username;
  final String firstName;

  @override
  List<Object?> get props => [email, password, username, firstName];
}
