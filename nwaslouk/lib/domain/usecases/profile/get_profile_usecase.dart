import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/user_profile.dart';
import '../../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;
  const GetProfileUseCase(this.repository);

  Future<Either<Failure, UserProfile>> call() {
    return repository.getProfile();
  }
}