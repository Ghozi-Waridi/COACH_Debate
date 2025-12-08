// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
  session_id: json['session_id'] as String,
  topic: json['topic'] as String,
  history: (json['history'] as List<dynamic>)
      .map((e) => Map<String, String>.from(e as Map))
      .toList(),
);

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'session_id': instance.session_id,
      'topic': instance.topic,
      'history': instance.history,
    };

HistoryMessageModel _$HistoryMessageModelFromJson(Map<String, dynamic> json) =>
    HistoryMessageModel(
      role: json['role'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$HistoryMessageModelToJson(
  HistoryMessageModel instance,
) => <String, dynamic>{
  'role': instance.role,
  'content': instance.content,
  'timestamp': instance.timestamp.toIso8601String(),
};
