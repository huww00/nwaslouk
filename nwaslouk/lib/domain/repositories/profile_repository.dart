import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getProfile();
  Future<Either<Failure, UserProfile>> updateProfile({String? name, String? phone, String? location, bool? isDriver, String? email});
  Future<Either<Failure, void>> changePassword({required String currentPassword, required String newPassword});
}