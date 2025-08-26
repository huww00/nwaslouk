import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/auth_token.dart';
import '../../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;
  const SignInWithGoogleUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call() {
    return repository.signInWithGoogle();
  }
}