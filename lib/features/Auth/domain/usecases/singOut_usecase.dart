import 'package:dartz/dartz.dart';
import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Auth/domain/repositories/auth_repository.dart';

class SingoutUsecase {
  final AuthRepository repository;

  SingoutUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
