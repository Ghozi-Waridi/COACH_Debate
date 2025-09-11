import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Profile/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> updateProfile(ProfileEntity profileData);
  Future<Either<Failure, ProfileEntity>> fetchProfile();
}
