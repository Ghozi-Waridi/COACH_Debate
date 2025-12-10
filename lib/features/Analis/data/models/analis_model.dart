import 'package:choach_debate/features/Analis/domain/entities/analis_entity.dart';

/// Model untuk statistik keseluruhan debat pengguna
class AnalyticsModel extends AnalyticsEntity {
  const AnalyticsModel({
    required super.totalSessions,
    required super.averageScore,
    required super.masteredTopics,
    required super.totalTime,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      totalSessions: json['total_sessions'] as int? ?? 0,
      averageScore: (json['average_score'] as num?)?.toDouble() ?? 0.0,
      masteredTopics: json['mastered_topics'] as int? ?? 0,
      totalTime: json['total_time'] as String? ?? '0h 0m',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_sessions': totalSessions,
      'average_score': averageScore,
      'mastered_topics': masteredTopics,
      'total_time': totalTime,
    };
  }

  factory AnalyticsModel.empty() {
    return const AnalyticsModel(
      totalSessions: 0,
      averageScore: 0.0,
      masteredTopics: 0,
      totalTime: '0h 0m',
    );
  }
}

/// Model untuk session debat individual
class SessionModel extends SessionEntity {
  const SessionModel({
    required super.sessionId,
    required super.topic,
    required super.score,
    required super.duration,
    required super.date,
    required super.messageCount,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      sessionId: json['session_id'] as String? ?? '',
      topic: json['topic'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      duration: json['duration'] as String? ?? '0 menit',
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : DateTime.now(),
      messageCount: json['message_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'topic': topic,
      'score': score,
      'duration': duration,
      'date': date.toIso8601String(),
      'message_count': messageCount,
    };
  }
}
