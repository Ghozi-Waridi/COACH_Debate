import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';
import 'package:choach_debate/features/Debate/domain/usecases/create_session_usecase.dart';
import 'package:choach_debate/features/Debate/domain/usecases/send_message_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'debate_event.dart';
part 'debate_state.dart';

class DebateBloc extends Bloc<DebateEvent, DebateState> {
  final SendmessageUsecase sendMessage;
  final CreateSessionUsecase createSession;

  String currentsession_id = '';
  List<ChatEntity> messages = [];

  DebateBloc({required this.sendMessage, required this.createSession})
    : super(DebateInitial()) {
    on<CreateSessionEvent>(_onCreateSession);
    on<SendMessageEvent>(_onSendMessage);
    on<LoadExistingSessionEvent>(_onLoadExistingSession);
  }

  Future<void> _onLoadExistingSession(
    LoadExistingSessionEvent event,
    Emitter<DebateState> emit,
  ) async {
    currentsession_id = event.sessionId;
    messages = List.from(event.existingMessages);
    emit(DebatLoaded(messages: List.from(messages)));
  }

  Future<void> _onCreateSession(
    CreateSessionEvent event,
    Emitter<DebateState> emit,
  ) async {
    messages = [];
    currentsession_id = '';

    final userMsg = ChatEntity(
      role: 'user',
      content: event.prompt,
      session_id: null,
    );
    messages.add(userMsg);
    emit(DebatLoaded(messages: List.from(messages)));

    try {
      emit(DebateLoading());
      final res = await createSession(
        prompt: event.prompt,
        topic: event.topic,
        role: event.role,
      );

      final sidRaw = res["session_id"];
      print("session_id: $sidRaw");
      print("session_id: ${sidRaw.runtimeType}");
      final respRaw = res["response"];

      // Validasi response
      if (respRaw == null) {
        throw Exception("response kosong");
      }

      currentsession_id = sidRaw;

      final aiMsg = ChatEntity(
        role: 'assistant',
        content: respRaw.toString(),
        session_id: currentsession_id,
      );
      messages.add(aiMsg);
      emit(DebatLoaded(messages: List.from(messages)));
    } catch (e) {
      emit(DebateError(message: e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<DebateState> emit,
  ) async {
    if (currentsession_id == 0) {
      emit(
        const DebateError(
          message: "Sesi belum dibuat. Kirim pesan pertama untuk memulai.",
        ),
      );
      return;
    }

    final userMsg = ChatEntity(
      role: 'user',
      content: event.prompt,
      session_id: currentsession_id,
    );
    messages.add(userMsg);
    emit(DebatLoaded(messages: List.from(messages)));

    try {
      emit(DebateLoading());
      final aiMsg = await sendMessage(
        prompt: event.prompt,
        session_id: currentsession_id,
      );
      messages.add(aiMsg);
      emit(DebatLoaded(messages: List.from(messages)));
    } catch (e) {
      emit(DebateError(message: e.toString()));
    }
  }
}
