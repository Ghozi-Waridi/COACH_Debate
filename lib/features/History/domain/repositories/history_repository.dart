import 'package:choach_debate/features/History/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntity>> getAllHistories();
  Future<HistoryEntity> getHistory(String session_id);
  Future<void> deleteHistory(String session_id);
}
