import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<String, String>> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    String? location,
    bool isDriver = false,
  }) async {
    try {
      final token = await remoteDataSource.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        location: location,
        isDriver: isDriver,
      );

      // Save token locally
      await localDataSource.saveToken(token);

      return Right(token);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> signIn({
    String? email,
    String? phone,
    required String password,
  }) async {
    try {
      final token = await remoteDataSource.signIn(
        email: email,
        phone: phone,
        password: password,
      );

      // Save token locally
      await localDataSource.saveToken(token);

      return Right(token);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> signInWithGoogle() async {
    try {
      final token = await remoteDataSource.signInWithGoogle();

      // Save token locally
      await localDataSource.saveToken(token);

      return Right(token);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AuthUser>> getCurrentUser(String token) async {
    try {
      final user = await remoteDataSource.getCurrentUser(token);
      
      // Save user data locally
      await localDataSource.saveUserData(jsonEncode(user.toJson()));

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      // Clear local data
      await localDataSource.deleteToken();
      await localDataSource.deleteUserData();
      
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> isAuthenticated() async {
    try {
      final token = await localDataSource.getToken();
      return Right(token != null && token.isNotEmpty);
    } catch (e) {
      return Left(e.toString());
    }
  }
}