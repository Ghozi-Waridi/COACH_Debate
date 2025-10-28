import 'package:choach_debate/features/History/data/datasources/history_datasource.dart';
import 'package:choach_debate/features/History/domain/entities/history_entity.dart';
import 'package:choach_debate/features/History/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDatasource datasource;

  HistoryRepositoryImpl({required this.datasource});

  @override
  Future<List<HistoryEntity>> getHistory(String session_id) async {
    try {
      final models = await datasource.getHistory(session_id);
      return models; 
    } catch (e) {
      rethrow; 
    }
  }
}
