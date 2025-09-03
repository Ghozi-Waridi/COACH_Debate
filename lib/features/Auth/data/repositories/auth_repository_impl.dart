import 'package:choach_debate/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final dataUser = await remoteDataSource.getCurrentUserId();
      return Right(dataUser);
    } catch (e) {
      return Left(ServerFailure("${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure("${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final dataUser = await remoteDataSource.signUp(email, password);
      return Right(dataUser);
    } catch (e) {
      return Left(ServerFailure("${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, User>> singInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final dataUser = await remoteDataSource.signIn(email, password);
      return Right(dataUser);
    } catch (e) {
      return Left(ServerFailure("${e.toString()}"));
    }
  }
}
