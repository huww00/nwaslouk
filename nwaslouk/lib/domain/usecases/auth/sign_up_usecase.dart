import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/auth_token.dart';
import '../../repositories/auth_repository.dart';

class SignUpParams {
  final String email;
  final String password;
  final String? name;
  final String? phone;
  final String? location;
  final bool isDriver;

  const SignUpParams({
    required this.email,
    required this.password,
    this.name,
    this.phone,
    this.location,
    this.isDriver = false,
  });
}

class SignUpUseCase {
  final AuthRepository repository;
  const SignUpUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call(SignUpParams params) {
    return repository.signUp(
      email: params.email,
      password: params.password,
      name: params.name,
      phone: params.phone,
      location: params.location,
      isDriver: params.isDriver,
    );
  }
}