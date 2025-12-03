import 'package:choach_debate/features/History/data/datasources/history_datasource.dart';
import 'package:choach_debate/features/History/domain/entities/history_entity.dart';
import 'package:choach_debate/features/History/domain/repositories/history_repository.dart';
import 'package:choach_debate/shared/utils/logger.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDatasource datasource;

  HistoryRepositoryImpl({required this.datasource});

  @override
  Future<List<HistoryEntity>> getAllHistories() async {
    try {
      final response = await datasource.getAllHistory();
      AppLogger.info("[Repository] GetAllHistory - Response: $response");

      final dataResponse = response.map((e) {
        return HistoryEntity(
          session_id: e.session_id,
          topic: e.topic,
          history: e.history,
        );
      }).toList();

      AppLogger.info(
        "[Repository] GetAllHistory - Mapped ${dataResponse.length} items",
      );
      return dataResponse;
    } catch (e) {
      AppLogger.error("[Repository] GetAllHistory - ERROR", e);
      rethrow; // Lempar ulang error agar bisa ditangani di BLoC
    }
  }

  @override
  Future<HistoryEntity> getHistory(String session_id) async {
    try {
      final response = await datasource.getHistory(session_id);
      AppLogger.info("[Repository] GetHistory - Session: $session_id");
      return HistoryEntity(
        session_id: response.session_id,
        topic: response.topic,
        history: response.history,
      );
    } catch (e) {
      AppLogger.error("[Repository] GetHistory - ERROR", e);
      rethrow;
    }
  }

  @override
  Future<void> deleteHistory(String session_id) async {
    try {
      AppLogger.info("[Repository] DeleteHistory - Session: $session_id");
      await datasource.deleteHistory(session_id);
      AppLogger.info("[Repository] ✅ DeleteHistory - Success");
    } catch (e) {
      AppLogger.error("[Repository] DeleteHistory - ERROR", e);
      rethrow;
    }
  }
}
