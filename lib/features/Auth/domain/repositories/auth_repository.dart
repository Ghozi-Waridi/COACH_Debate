import 'package:choach_debate/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:choach_debate/features/Auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> singInWithEmailPassword(
    String email,
    String password,
  );
  Future<Either<Failure, User>> signUpWithEmailPassword(
    String email,
    String password,
  );
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User?>> getCurrentUser();
}
