import 'package:choach_debate/features/Topics/domain/repositories/topic_repository.dart';

class GetCategoriUsecase {
  final TopicRepository repository;

  GetCategoriUsecase({required this.repository});

  Future<List<String>> call() {
    return repository.getCategories();
  }
}
