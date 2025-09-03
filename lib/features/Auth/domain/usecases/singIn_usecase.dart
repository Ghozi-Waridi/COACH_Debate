import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Auth/domain/entities/auth_entity.dart';
import 'package:choach_debate/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SinginUsecase {
  final AuthRepository repository;
  SinginUsecase(this.repository);
  @override
  Future<Either<Failure, User>> call(String email, String password) {
    return repository.singInWithEmailPassword(email, password);
  }
}
