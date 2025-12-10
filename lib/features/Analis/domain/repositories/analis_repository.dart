import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Analis/domain/entities/analis_entity.dart';
import 'package:dartz/dartz.dart';

/// Repository interface untuk fitur analisis
abstract class AnalisRepository {
  /// Mendapatkan statistik analytics keseluruhan
  Future<Either<Failure, AnalyticsEntity>> getAnalytics();

  /// Mendapatkan daftar session terbaru (default: 5 session)
  Future<Either<Failure, List<SessionEntity>>> getRecentSessions({
    int limit = 5,
  });
}
