import 'package:equatable/equatable.dart';

/// Base event untuk Analis
abstract class AnalisEvent extends Equatable {
  const AnalisEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk load analytics dan recent sessions
class LoadAnalisDataEvent extends AnalisEvent {
  const LoadAnalisDataEvent();
}

/// Event untuk refresh data
class RefreshAnalisDataEvent extends AnalisEvent {
  const RefreshAnalisDataEvent();
}
