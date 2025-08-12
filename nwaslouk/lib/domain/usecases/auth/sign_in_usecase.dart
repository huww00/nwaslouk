import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/auth_token.dart';
import '../../repositories/auth_repository.dart';

class SignInParams {
  final String identifier;
  final String password;
  const SignInParams({required this.identifier, required this.password});
}

class SignInUseCase {
  final AuthRepository repository;
  const SignInUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call(SignInParams params) {
    return repository.signIn(identifier: params.identifier, password: params.password);
  }
}