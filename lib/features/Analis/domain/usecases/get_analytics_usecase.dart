import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Analis/domain/entities/analis_entity.dart';
import 'package:choach_debate/features/Analis/domain/repositories/analis_repository.dart';
import 'package:dartz/dartz.dart';

/// UseCase untuk mendapatkan analytics statistics
class GetAnalyticsUseCase {
  final AnalisRepository repository;

  GetAnalyticsUseCase(this.repository);

  Future<Either<Failure, AnalyticsEntity>> call() async {
    return await repository.getAnalytics();
  }
}
