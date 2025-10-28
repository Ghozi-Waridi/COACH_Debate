import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String role;
  final String content;
  final String? session_id;

  const ChatEntity({required this.role, required this.content, this.session_id});

  @override
  List<Object?> get props => [role, content, session_id];
}
