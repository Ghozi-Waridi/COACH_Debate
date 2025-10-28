import 'package:choach_debate/features/History/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntity>> getHistory(String session_id);
}