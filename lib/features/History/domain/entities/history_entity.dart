import 'package:equatable/equatable.dart';

class HistoryEntity extends Equatable {
  final String session_id;
  final String topic;
  final List<String> history;

  HistoryEntity({required this.session_id, required this.topic, required this.history});
  
  @override
  
  List<Object?> get props => [session_id, topic, history];


}