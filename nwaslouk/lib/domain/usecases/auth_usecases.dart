import 'package:dartz/dartz.dart';
import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<String, String>> call({
    required String email,
    required String password,
    String? name,
    String? phone,
    String? location,
    bool isDriver = false,
  }) {
    return repository.signUp(
      email: email,
      password: password,
      name: name,
      phone: phone,
      location: location,
      isDriver: isDriver,
    );
  }
}

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<String, String>> call({
    String? email,
    String? phone,
    required String password,
  }) {
    return repository.signIn(
      email: email,
      phone: phone,
      password: password,
    );
  }
}

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<Either<String, String>> call() {
    return repository.signInWithGoogle();
  }
}

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<String, AuthUser>> call(String token) {
    return repository.getCurrentUser(token);
  }
}

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<String, void>> call() {
    return repository.logout();
  }
}

class IsAuthenticatedUseCase {
  final AuthRepository repository;

  IsAuthenticatedUseCase(this.repository);

  Future<Either<String, bool>> call() {
    return repository.isAuthenticated();
  }
}