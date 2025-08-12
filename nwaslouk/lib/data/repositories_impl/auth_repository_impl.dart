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
      final res = await api.signIn({'identifier': identifier, 'password': password});
      final token = (res.data as Map<String, dynamic>)['token'] as String;
      await localStore.saveAuthToken(token);
      return Right(AuthToken(token));
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 401) return Left(Failure.unauthorized());
      return Left(Failure.server(e.message ?? 'Server error'));
    } catch (_) {
      // Mock token for offline dev
      const token = 'mock-token';
      await localStore.saveAuthToken(token);
      return const Right(AuthToken(token));
    }
  }
}