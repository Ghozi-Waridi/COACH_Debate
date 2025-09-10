import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Profile/domain/entities/profile_entity.dart';
import 'package:choach_debate/features/Profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class FetchprofileUsecase {
  final ProfileRepository repository;

  FetchprofileUsecase({required this.repository});

  @override
  Future<Either<Failure, ProfileEntity>> call() {
    return repository.fetchProfile();
  }
}
