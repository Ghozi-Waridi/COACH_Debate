import 'package:equatable/equatable.dart';

class HistoryEntity extends Equatable {
  final String session_id;
  final String topic;
  final List<Map<String, String>> history;

  HistoryEntity({
    required this.session_id,
    required this.topic,
    required this.history,
  });

  @override
  List<Object?> get props => [session_id, topic, history];
}




class HistoryMessageEntity extends Equatable{
  final String role;
  final String content;
  final DateTime timestamp;

  HistoryMessageEntity({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [role, content, timestamp];
}