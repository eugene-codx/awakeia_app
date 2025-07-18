import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

/// Base class for all use cases in the application
/// Type [T] is the return type, [Params] is the parameters type
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Base class for use cases that don't require parameters
abstract class NoParamsUseCase<T> {
  Future<Either<Failure, T>> call();
}

/// Class to represent when no parameters are needed
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
