import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends ChatEntity {
  const ChatModel({
    required super.role,
    required super.content,
    super.session_id,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
