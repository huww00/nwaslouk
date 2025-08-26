import 'package:dartz/dartz.dart';
import '../entities/auth_token.dart';
import '../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> signIn({
    required String identifier,
    required String password,
  });

  Future<Either<Failure, AuthToken>> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    String? location,
    bool isDriver = false,
  });

  Future<Either<Failure, AuthToken>> signInWithGoogle();

  Future<Either<Failure, void>> logout();
}