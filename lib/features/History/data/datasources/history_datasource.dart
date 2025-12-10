import 'package:choach_debate/core/config/api_config.dart';
import 'package:choach_debate/features/History/data/models/history_model.dart';
import 'package:choach_debate/shared/utils/logger.dart';
// import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';

abstract class HistoryDatasource {
  Future<HistoryModel> getHistory(String session_id);
  Future<List<HistoryModel>> getAllHistory();
  Future<void> deleteHistory(String session_id);
}

class HistoryDatasourceImpl implements HistoryDatasource {
  final Dio dio;
  HistoryDatasourceImpl({required this.dio});

  @override
  Future<List<HistoryModel>> getAllHistory() async {
    try {
      final response = await dio.get(ApiConfig.historyEndpoint);
      AppLogger.info("[Datasource] 📦 Response Status: ${response.statusCode}");
      AppLogger.info(
        "[Datasource] 📦 Response Type: ${response.data.runtimeType}",
      );

      if (response.statusCode == 200) {
        // ✅ API mengembalikan {"sessions": [...]}
        final List<dynamic> data = response.data is List
            ? response.data
            : response.data['sessions'] ??
                  []; // 🔧 PERBAIKAN: gunakan 'sessions' bukan 'data'

        AppLogger.info("[Datasource] 📋 Total sessions found: ${data.length}");

        final historyList = data
            .map((json) => HistoryModel.fromJson(json))
            .toList();
        AppLogger.info(
          "[Datasource] ✅ Successfully mapped ${historyList.length} items",
        );

        return historyList;
      } else {
        throw Exception('Failed to load history: ${response.statusCode}');
      }
    } catch (e) {
      AppLogger.error("[Datasource] ❌ GetHistoryAll - ERROR", e);
      rethrow;
    }
  }

  @override
  Future<HistoryModel> getHistory(String session_id) async {
    try {
      final response = await dio.post(
        ApiConfig.historyEndpoint + "/${session_id}history/",
      );

      if (response.statusCode == 200) {
        return HistoryModel.fromJson(response.data);
      }
      throw Exception(
        "Format respons tidak sesuai / statusCode: ${response.statusCode}",
      );
    } catch (e) {
      AppLogger.error("[Datasource] GetHistoru - ERROR", e);
      rethrow;
    }
  }

  @override
  Future<void> deleteHistory(String session_id) async {
    try {
      // Backend URL: /api/history/<session_id>/history
      final url = '${ApiConfig.historyEndpoint}$session_id/history';
      AppLogger.info("[Datasource] 🗑️ DELETE REQUEST");
      AppLogger.info("[Datasource] 📍 Session ID: $session_id");
      AppLogger.info("[Datasource] 🌐 Full URL: $url");

      final response = await dio.delete(url);

      AppLogger.info("[Datasource] 📡 Response Status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        AppLogger.info("[Datasource] ✅ Session deleted successfully");
        return;
      }
      throw Exception('Failed to delete history: ${response.statusCode}');
    } catch (e) {
      AppLogger.error("[Datasource] ❌ DeleteHistory - ERROR", e);
      rethrow;
    }
  }
}
