import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/user_profile.dart';
import '../../repositories/profile_repository.dart';

class UpdateProfileParams {
  final String? name;
  final String? phone;
  const UpdateProfileParams({this.name, this.phone});
}

class UpdateProfileUseCase {
  final ProfileRepository repository;
  const UpdateProfileUseCase(this.repository);

  Future<Either<Failure, UserProfile>> call(UpdateProfileParams params) {
    return repository.updateProfile(name: params.name, phone: params.phone);
  }
}