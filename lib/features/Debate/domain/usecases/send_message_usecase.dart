import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';
import 'package:choach_debate/features/Debate/domain/repositories/chat_repository.dart';

class SendmessageUsecase {
  final ChatRepository repository;

  SendmessageUsecase({required this.repository});

  Future<ChatEntity> call({
    required String prompt,
    required String session_id,
  }) async {
    return await repository.sendMessage(prompt: prompt, session_id: session_id);
  }
}
