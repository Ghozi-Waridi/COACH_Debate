import 'package:choach_debate/features/Topics/domain/entities/topic_entity.dart';
import 'package:choach_debate/features/Topics/domain/repositories/topic_repository.dart';

class GetTopicUsecase {
  final TopicRepository repository;

  GetTopicUsecase({required this.repository});

  Future<List<TopicEntity>> call(String categori) {
    return repository.getTopics(categori);
  }
}
