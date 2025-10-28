import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<ChatEntity> sendMessage({
    required String prompt,
    required String session_id,
  });

  Future<Map<String, dynamic>> createSession({
    required String prompt,
    required String topic,
    required String role,
  });
}
