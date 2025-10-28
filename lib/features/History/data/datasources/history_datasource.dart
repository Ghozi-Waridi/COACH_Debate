import 'package:choach_debate/core/config/api_config.dart';
import 'package:choach_debate/features/History/data/models/history_model.dart';
import 'package:choach_debate/shared/utils/logger.dart';
import 'package:dio/dio.dart';

abstract class HistoryDatasource {
  Future<List<HistoryModel>> getHistory(String session_id);
}

class HistoryDatasourceImpl implements HistoryDatasource {
  final Dio dio;
  HistoryDatasourceImpl({required this.dio});

  @override
  Future<List<HistoryModel>> getHistory(String session_id) async {
    try {
      final response = await dio.get(
        ApiConfig.historyEndpoint + "/$session_id/history",
      );
      if (response.statusCode == 200) {
        if (response.data is List) {
          final List<dynamic> dataList = response.data;
          final models = dataList
              .map((json) => HistoryModel.fromJson(json))
              .toList();
          print("Tipe data model di history : ${models.runtimeType}");
          return models;
        } else if (response.data is Map<String, dynamic>) {
          final model = HistoryModel.fromJson(response.data);
          return [model];
        } else {
          throw Exception("Format data tidak valid");
        }
      } else {
        throw Exception(
          "Gagal mendapatkan data history: ${response.statusCode}",
        );
      }
    } catch (e, st) {
      AppLogger.error("getHistory error", e);
      AppLogger.error("stack", st);
      rethrow;
    }
  }
}
