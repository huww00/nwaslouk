import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local/local_store.dart';
import '../datasources/remote/profile_api.dart';
import '../datasources/mock/mock_data.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApi api;
  final LocalStore localStore;
  final MockData mockData;
  ProfileRepositoryImpl({required this.api, required this.localStore, required this.mockData});

  @override
  Future<Either<Failure, UserProfile>> getProfile() async {
    try {
      final res = await api.getProfile();
      final profile = UserProfile.fromJson(res.data as Map<String, dynamic>);
      return Right(profile);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 401) return Left(Failure.unauthorized());
      return Left(Failure.server(e.message ?? 'Server error'));
    } catch (_) {
      return Right(mockData.profile);
    }
  }
}