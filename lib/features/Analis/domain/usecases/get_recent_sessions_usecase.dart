import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Analis/domain/entities/analis_entity.dart';
import 'package:choach_debate/features/Analis/domain/repositories/analis_repository.dart';
import 'package:dartz/dartz.dart';

/// UseCase untuk mendapatkan recent sessions
class GetRecentSessionsUseCase {
  final AnalisRepository repository;

  GetRecentSessionsUseCase(this.repository);

  Future<Either<Failure, List<SessionEntity>>> call({int limit = 5}) async {
    return await repository.getRecentSessions(limit: limit);
  }
}
