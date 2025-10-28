// import 'package:choach_debate/features/Debate/data/datasources/chat_datasource.dart';
// import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';
// import 'package:choach_debate/features/Debate/domain/repositories/chat_repository.dart';

// class ChatRepositoryImpl implements ChatRepository {
//   final ChatDatasource datasource;

//   ChatRepositoryImpl({required this.datasource});

//   @override
//   Future<ChatEntity> sendMessage({
//     required String prompt,
//     int? session_id,
//     String? topic,
//     String? role,
//   }) async {
//     try {
//       final response = await datasource.sendMessage(
//         prompt: prompt,
//         session_id: session_id,
//         // topic: topic,
//         // role: role,
//       );

//       if (response.containsKey("response")) {
//         final aiResponse = ChatEntity(
//           role: 'assistant',
//           content: response["response"],
//           session_id: response["session_id"],
//         );
//         return aiResponse;
//       } else {
//         throw Exception("Response tidak mengandung kunci 'response'");
//       }
//     } catch (e) {
//       throw Exception("Gagal mengirim pesan: $e");
//     }
//   }

//   @override
//   Future<ChatEntity> createSession({
//     required String prompt,
//     required String topic,
//     required String role,
//   }) async {
//     try {
//       final response = await datasource.createSession(
//         prompt: prompt,
//         topic: topic,
//         role: role,
//       );
//       if (response.containsKey("response")) {
//         final aiResponse = ChatEntity(
//           role: 'assistant',
//           content: response["response"],
//           session_id: response["session_id"],
//         );
//         return aiResponse;
//       } else {
//         throw Exception("Response tidak mengandung kunci 'response'");
//       }
//     } catch (e) {
//       throw Exception("Gagal membuat sesi: $e");
//     }
//   }
// }

import 'package:choach_debate/features/Debate/data/datasources/chat_datasource.dart';
import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';
import 'package:choach_debate/features/Debate/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource datasource;

  ChatRepositoryImpl({required this.datasource});

  @override
  Future<ChatEntity> sendMessage({
    required String prompt,
    required String session_id,
  }) async {
    final response = await datasource.sendMessage(
      prompt: prompt,
      session_id: session_id,
    );

    if (!response.containsKey("response")) {
      throw Exception("Response tidak mengandung kunci 'response'");
    }

    return ChatEntity(
      role: 'assistant',
      content: (response["response"] ?? "").toString(),
      session_id: response["session_id"]?.toString(),
    );
  }

  @override
  Future<Map<String, dynamic>> createSession({
    required String prompt,
    required String topic,
    required String role,
  }) async {
    return await datasource.createSession(
      prompt: prompt,
      topic: topic,
      role: role,
    );
  }
}
