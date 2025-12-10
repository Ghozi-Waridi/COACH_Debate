import 'package:equatable/equatable.dart';

/// Entity untuk statistik keseluruhan debat pengguna
class AnalyticsEntity extends Equatable {
  final int totalSessions;
  final double averageScore;
  final int masteredTopics;
  final String totalTime;

  const AnalyticsEntity({
    required this.totalSessions,
    required this.averageScore,
    required this.masteredTopics,
    required this.totalTime,
  });

  @override
  List<Object?> get props => [
    totalSessions,
    averageScore,
    masteredTopics,
    totalTime,
  ];
}

/// Entity untuk session debat individual
class SessionEntity extends Equatable {
  final String sessionId;
  final String topic;
  final double score;
  final String duration;
  final DateTime date;
  final int messageCount;

  const SessionEntity({
    required this.sessionId,
    required this.topic,
    required this.score,
    required this.duration,
    required this.date,
    required this.messageCount,
  });

  @override
  List<Object?> get props => [
    sessionId,
    topic,
    score,
    duration,
    date,
    messageCount,
  ];
}
