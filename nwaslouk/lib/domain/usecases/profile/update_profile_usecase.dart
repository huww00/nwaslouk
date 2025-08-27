import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/user_profile.dart';
import '../../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;
  const UpdateProfileUseCase(this.repository);

  Future<Either<Failure, UserProfile>> call({String? name, String? phone, String? location, bool? isDriver, String? email}) {
    return repository.updateProfile(name: name, phone: phone, location: location, isDriver: isDriver, email: email);
  }
}

