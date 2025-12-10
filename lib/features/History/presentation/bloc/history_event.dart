part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryEvent extends HistoryEvent {
  final String session_id;
  GetHistoryEvent(this.session_id);

  @override
  List<Object> get props => [session_id];
}

class GetAllHistoryEvent extends HistoryEvent {}

class DeleteHistoryEvent extends HistoryEvent {
  final String sessionId;
  const DeleteHistoryEvent(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}
