import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Analis/data/models/analis_model.dart';
import 'package:choach_debate/features/Analis/domain/entities/analis_entity.dart';
import 'package:choach_debate/features/Analis/domain/repositories/analis_repository.dart';
import 'package:choach_debate/features/History/domain/repositories/history_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementasi AnalisRepository yang mengambil data dari HistoryRepository
class AnalisRepositoryImpl implements AnalisRepository {
  final HistoryRepository historyRepository;

  AnalisRepositoryImpl({required this.historyRepository});

  @override
  Future<Either<Failure, AnalyticsEntity>> getAnalytics() async {
    try {
      // Ambil semua history
      final histories = await historyRepository.getAllHistories();

      if (histories.isEmpty) {
        return Right(AnalyticsModel.empty());
      }

      // Hitung total sessions
      final totalSessions = histories.length;

      // Hitung average score (simulasi - bisa diganti dengan logika real)
      // Untuk saat ini, kita gunakan perhitungan berdasarkan jumlah message
      double totalScore = 0;
      int totalMinutes = 0;

      for (var history in histories) {
        // Score berdasarkan jumlah message (lebih banyak message = lebih engaged)
        // Maksimal score 10
        final messageCount = history.history.length;
        final score = (messageCount / 10).clamp(0, 10).toDouble();
        totalScore += score;

        // Estimasi durasi: setiap message ~2 menit
        totalMinutes += messageCount * 2;
      }

      final averageScore = totalSessions > 0 ? totalScore / totalSessions : 0.0;

      // Hitung mastered topics (topik dengan score > 8.0)
      final masteredTopics = histories.where((h) {
        final messageCount = h.history.length;
        final score = (messageCount / 10).clamp(0, 10).toDouble();
        return score >= 8.0;
      }).length;

      // Format total time
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      final totalTime = '${hours}h ${minutes}m';

      return Right(
        AnalyticsModel(
          totalSessions: totalSessions,
          averageScore: double.parse(averageScore.toStringAsFixed(1)),
          masteredTopics: masteredTopics,
          totalTime: totalTime,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure('Gagal mengambil data analytics: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<SessionEntity>>> getRecentSessions({
    int limit = 5,
  }) async {
    try {
      // Ambil semua history
      final histories = await historyRepository.getAllHistories();

      if (histories.isEmpty) {
        return const Right([]);
      }

      // Convert ke SessionModel dan urutkan berdasarkan tanggal (terbaru dulu)
      final sessions = histories.map((history) {
        final messageCount = history.history.length;

        // Hitung score berdasarkan jumlah message
        final score = (messageCount / 10).clamp(0, 10).toDouble();

        // Estimasi durasi: setiap message ~2 menit
        final durationMinutes = messageCount * 2;
        final duration = '$durationMinutes menit';

        // Untuk tanggal, kita gunakan timestamp dari message terakhir jika ada
        DateTime date = DateTime.now();
        // Di sini bisa ditambahkan logic untuk parsing timestamp dari history

        return SessionModel(
          sessionId: history.session_id,
          topic: history.topic,
          score: double.parse(score.toStringAsFixed(1)),
          duration: duration,
          date: date,
          messageCount: messageCount,
        );
      }).toList();

      // Urutkan berdasarkan tanggal (terbaru dulu) - untuk sekarang berdasarkan session_id
      sessions.sort((a, b) => b.sessionId.compareTo(a.sessionId));

      // Ambil sejumlah limit
      final recentSessions = sessions.take(limit).toList();

      return Right(recentSessions);
    } catch (e) {
      return Left(
        ServerFailure('Gagal mengambil recent sessions: ${e.toString()}'),
      );
    }
  }
}
