import 'package:equatable/equatable.dart';

class TopicEntity extends Equatable {
  // final int id;
  final String topic;

  const TopicEntity({required this.topic});

  @override
  List<Object?> get props => [topic];
}
