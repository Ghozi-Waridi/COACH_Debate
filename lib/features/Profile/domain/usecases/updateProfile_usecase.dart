import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/profile_entity.dart';

class UpdateprofileUsecase {
  final ProfileRepository repository;

  UpdateprofileUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(ProfileEntity profileData) {
    return repository.updateProfile(profileData);
  }
}
