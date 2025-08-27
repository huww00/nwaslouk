import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../repositories/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository repository;
  const ChangePasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({required String currentPassword, required String newPassword}) {
    return repository.changePassword(currentPassword: currentPassword, newPassword: newPassword);
  }
}

