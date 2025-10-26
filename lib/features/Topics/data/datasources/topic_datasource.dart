import 'package:choach_debate/core/config/api_config.dart';
import 'package:choach_debate/features/Topics/data/models/topic_model.dart';
import 'package:choach_debate/features/Topics/domain/entities/topic_entity.dart';
import 'package:dio/dio.dart';

abstract class TopicDatasource {
  Future<List<TopicEntity>> getTopics(String categori);
  Future<List<String>> getCategories();
}

class TopicDatasourceImpl implements TopicDatasource {
  final Dio dio;
  TopicDatasourceImpl({required this.dio});
  
  // @override
  // Future<List<TopicModel>> getTopics() async {
  //   try {
  //     final response = await dio.get(ApiConfig.topicsEndpoint);
  //     if (response.statusCode == 200) {
  //       return TopicModel.fromJsonList(response.data);
  //     } else {
  //       throw Exception("Gagal mendapatkan data topik");
  //     }
  //   } catch (e) {
  //     throw Exception("Error fetching topics: $e");
  //   }
  // }

  @override
  Future<List<TopicEntity>> getTopics(String category) async {
    try {
      final response = await dio.get(ApiConfig.getNewsAPIurl(q: category));
      print("Data Topics : ${response.data["articles"]}");
      if (response.statusCode == 200) {
        final models = TopicModel.fromJsonList(response.data["articles"]);
        return models.cast<TopicEntity>();
      } else {
        throw Exception("Gagal mendapatkan data topik");
      }
    } catch (e) {
      throw Exception("Error fetching topics: $e");

    }
  }

  @override
  Future<List<String>> getCategories() {
    List<String> categories = [
      "business",
      "entertainment",
      "general",
      "health",
      "science",
      "sports",
    ];
    return Future.value(categories);
  }
}
