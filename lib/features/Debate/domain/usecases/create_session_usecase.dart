import 'package:choach_debate/features/Debate/domain/repositories/chat_repository.dart';

class CreateSessionUsecase {
  final ChatRepository repository;

  CreateSessionUsecase({required this.repository});

  Future<Map<String, dynamic>> call({
    required String prompt,
    required String topic,
    required String role,
  }) async {
    return await repository.createSession(
      prompt: prompt,
      topic: topic,
      role: role,
    );
  }
}
