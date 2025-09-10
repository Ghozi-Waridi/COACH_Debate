import 'package:choach_debate/features/Profile/data/datasources/profile_remote_data_source.dart';
import 'package:choach_debate/features/Profile/data/models/profile_model.dart';
import 'package:choach_debate/features/Profile/domain/entities/profile_entity.dart';
import 'package:choach_debate/features/Profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:choach_debate/core/error/failure.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl( this.dataSource);

  @override
  Future<Either<Failure, void>> updateProfile(ProfileEntity profileData) async {
    try {
      final model = ProfileModel(
        userName: profileData.userName,
        email: profileData.email,
        institusi: profileData.institusi,
      );
      await dataSource.updateProfile(model);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

@override
  Future<Either<Failure, ProfileEntity>> fetchProfile() async {
    try {
      final profile = await dataSource.fetchProfile();
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
