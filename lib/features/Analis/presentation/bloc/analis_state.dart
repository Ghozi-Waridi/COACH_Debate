import 'package:choach_debate/features/Analis/domain/entities/analis_entity.dart';
import 'package:equatable/equatable.dart';

/// Base state untuk Analis
abstract class AnalisState extends Equatable {
  const AnalisState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AnalisInitial extends AnalisState {
  const AnalisInitial();
}

/// Loading state
class AnalisLoading extends AnalisState {
  const AnalisLoading();
}

/// Loaded state dengan data analytics dan sessions
class AnalisLoaded extends AnalisState {
  final AnalyticsEntity analytics;
  final List<SessionEntity> recentSessions;

  const AnalisLoaded({required this.analytics, required this.recentSessions});

  @override
  List<Object?> get props => [analytics, recentSessions];
}

/// Error state
class AnalisError extends AnalisState {
  final String message;

  const AnalisError({required this.message});

  @override
  List<Object?> get props => [message];
}
