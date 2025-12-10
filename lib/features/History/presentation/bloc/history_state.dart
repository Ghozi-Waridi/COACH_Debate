part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> historyEntries;

  HistoryLoaded(this.historyEntries);

  @override
  List<Object> get props => [historyEntries];
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);

  @override
  List<Object> get props => [message];
}

class HistoryDetaulLoaded extends HistoryState {
  final HistoryEntity historyDetail;

  HistoryDetaulLoaded(this.historyDetail);

  @override
  List<Object> get props => [historyDetail];
}

class HistoryDeleteSuccess extends HistoryState {
  final String message;

  HistoryDeleteSuccess({this.message = 'Riwayat berhasil dihapus'});

  @override
  List<Object> get props => [message];
}
