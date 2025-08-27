import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/auth_token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/local_store.dart';
import '../datasources/remote/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;
  final LocalStore localStore;
  AuthRepositoryImpl({required this.api, required this.localStore});

  @override
  Future<Either<Failure, AuthToken>> signIn({required String identifier, required String password}) async {
    try {
      final bool isEmail = identifier.contains('@');
      final Map<String, dynamic> body = {
        if (isEmail) 'email': identifier else 'phone': identifier,
        'password': password,
      };
      final res = await api.signIn(body);
      final token = (res.data as Map<String, dynamic>)['token'] as String;
      await localStore.saveAuthToken(token);
      return Right(AuthToken(token));
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 401) return Left(Failure.unauthorized());
      return Left(Failure.server(e.message ?? 'Server error'));
    } catch (e) {
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> signUp({
    required String email,
    required String password,
    String? name,
    String? phone,
    String? location,
    bool isDriver = false,
  }) async {
    try {
      final body = {
        'email': email,
        'password': password,
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (location != null) 'location': location,
        'isDriver': isDriver,
      };
      final res = await api.signUp(body);
      final token = (res.data as Map<String, dynamic>)['token'] as String;
      await localStore.saveAuthToken(token);
      return Right(AuthToken(token));
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 409) return Left(Failure.validation('Email or phone already in use'));
      return Left(Failure.server(e.message ?? 'Server error'));
    } catch (e) {
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await api.logout();
    } catch (_) {
      // ignore network error for logout in stateless JWT
    }
    await localStore.clear();
    return const Right(null);
  }
}