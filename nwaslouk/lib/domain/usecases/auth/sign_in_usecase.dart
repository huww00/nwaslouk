import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/auth_token.dart';
import '../../repositories/auth_repository.dart';

class SignInParams {
  final String phone;
  final String otp;
  const SignInParams({required this.phone, required this.otp});
}

class SignInUseCase {
  final AuthRepository repository;
  const SignInUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call(SignInParams params) {
    return repository.signIn(phone: params.phone, otp: params.otp);
  }
}