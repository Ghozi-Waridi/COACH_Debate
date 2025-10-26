import 'package:choach_debate/features/Topics/domain/entities/topic_entity.dart';

abstract class TopicRepository {
  Future<List<TopicEntity>> getTopics(String categori);
  Future<List<String>> getCategories();
}
