import 'package:choach_debate/features/History/domain/entities/history_entity.dart';
import 'package:choach_debate/features/History/domain/repositories/history_repository.dart';

class GethistoryUsecase {
  HistoryRepository repository;

  GethistoryUsecase({required this.repository});

  Future<List<HistoryEntity>> call(String session_id) async {
    return await repository.getHistory(session_id);
  }
}