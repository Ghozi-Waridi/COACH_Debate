import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SingupUsecase {
  final AuthRepository repository;

  SingupUsecase(this.repository);

  @override
  Future<Either<Failure, User>> call(
    String email,
    String password,
    Map<String, dynamic> user,
  ) {
    return repository.signUpWithEmailPassword(email, password, user);
  }
}
