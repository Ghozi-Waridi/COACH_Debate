import 'package:choach_debate/features/History/domain/entities/history_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel extends HistoryEntity {
  HistoryModel({
    required super.session_id,
    required super.topic,
    required super.history,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      session_id:
          json['session_id']?.toString() ?? '', // 🔧 Convert int to String
      topic: json['topic']?.toString() ?? 'No Topic', // 🔧 Handle null
      history:
          (json['history'] as List<dynamic>?)
              ?.map(
                (item) => Map<String, String>.from({
                  'role': item['role']?.toString() ?? '',
                  'content': item['content']?.toString() ?? '',
                  'timestamp': item['timestamp']?.toString() ?? '',
                }),
              )
              .toList() ??
          [], // 🔧 Convert properly
    );
  }

  Map<String, dynamic> toJson() {
    return {'session_id': session_id, 'topic': topic, 'history': history};
  }
}

@JsonSerializable()
class HistoryMessageModel extends HistoryMessageEntity {
  HistoryMessageModel({
    required super.role,
    required super.content,
    required super.timestamp,
  });

  factory HistoryMessageModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryMessageModelToJson(this);
}
