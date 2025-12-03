import 'package:choach_debate/features/History/domain/repositories/history_repository.dart';

class DeleteHistoryUsecase {
  final HistoryRepository repository;

  DeleteHistoryUsecase({required this.repository});

  Future<void> call(String sessionId) async {
    return await repository.deleteHistory(sessionId);
  }
}
