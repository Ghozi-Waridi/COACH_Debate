import 'package:choach_debate/features/History/domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  HistoryModel({
    required super.session_id,
    required super.topic,
    required super.history,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      session_id: json['session_id'],
      topic: json['topic'],
      history: json['history'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'session_id': session_id, 'topic': topic, 'history': history};
  }
}
