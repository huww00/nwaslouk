import 'package:dartz/dartz.dart';
import '../entities/auth_user.dart';

abstract class AuthRepository {
  // Local authentication
  Future<Either<String, String>> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    String? location,
    bool isDriver = false,
  });

  Future<Either<String, String>> signIn({
    String? email,
    String? phone,
    required String password,
  });

  // Google authentication
  Future<Either<String, String>> signInWithGoogle();

  // General
  Future<Either<String, AuthUser>> getCurrentUser(String token);
  Future<Either<String, void>> logout();
  Future<Either<String, bool>> isAuthenticated();
}