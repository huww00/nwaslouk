import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/auth_token.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> signIn({
    required String identifier,
    required String password,
  });
}