import 'package:choach_debate/features/History/domain/entities/history_entity.dart';
import 'package:choach_debate/features/History/domain/repositories/history_repository.dart';

class GetallhistoryUsecase {
  HistoryRepository repository;

  GetallhistoryUsecase({required this.repository});

  @override
  Future<List<HistoryEntity>> call() async {
    return await repository.getAllHistories();
  }
}
