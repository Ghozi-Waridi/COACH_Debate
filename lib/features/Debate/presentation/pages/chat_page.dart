import 'dart:ui';
import 'package:choach_debate/core/theme/color.dart';
import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';
import 'package:choach_debate/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:choach_debate/features/Debate/presentation/widgets/chat_bubble_widget.dart';
import 'package:choach_debate/features/Debate/presentation/widgets/message_input_widget.dart';
import 'package:choach_debate/features/Debate/presentation/widgets/typing_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatPage extends StatefulWidget {
  final String topic;
  final String role; // Pro/Kontra

  const ChatPage({super.key, required this.topic, required this.role});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  late SpeechToText _speechToText;
  late FlutterTts _flutterTts;
  bool _speechEnabled = false;
  bool _isUserStopped = true;

  int _lastItemCount = 0;

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
    _flutterTts = FlutterTts();
    _initTextToSpeech();
    _initSpeech();
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    _flutterTts.stop();
    _speechToText.stop();
    super.dispose();
  }

  Future<void> _initTextToSpeech() async {
    await _flutterTts.setLanguage("id-ID");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
  }

  void _speak(String text) async {
    await _flutterTts.stop();
    await _flutterTts.speak(text);
  }

  void _stop() async => await _flutterTts.stop();

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (!_speechEnabled) return;
    _stop();
    setState(() => _isUserStopped = false);
    _textCtrl.clear();
    await _speechToText.listen(
      pauseFor: const Duration(minutes: 10),
      localeId: 'id_ID',
      onResult: _onSpeechResult,
    );
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() => _isUserStopped = true);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _textCtrl.text = result.recognizedWords;
      _textCtrl.selection = TextSelection.fromPosition(
        TextPosition(offset: _textCtrl.text.length),
      );
    });
  }

  void _handleSend() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;

    _stop();
    final bloc = context.read<DebateBloc>();
    if (bloc.currentsession_id == 0) {
      bloc.add(
        CreateSessionEvent(
          prompt: text,
          topic: widget.topic,
          role: widget.role,
        ),
      );
    } else {
      bloc.add(SendMessageEvent(text));
    }
    _textCtrl.clear();
    if (!_isUserStopped) _stopListening();
  }

  void _scrollToBottom({bool animated = true}) {
    if (!_scrollCtrl.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final offset = _scrollCtrl.position.maxScrollExtent;
      if (animated) {
        _scrollCtrl.animateTo(
          offset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      } else {
        _scrollCtrl.jumpTo(offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.15),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Debate Room",
              style: TextStyle(
                color: AppColor.blueDark,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "${widget.topic} • ${widget.role}",
              style: TextStyle(
                color: AppColor.blueDark.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.accent,
              size: 18,
            ),
          ),
          onPressed: () async {
            _stop();
            await _speechToText.stop();
            FocusScope.of(context).unfocus();
            await Future<void>.delayed(const Duration(milliseconds: 20));
            if (context.mounted) Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.more_vert_rounded,
                color: AppColor.accent,
                size: 18,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<DebateBloc, DebateState>(
              listener: (context, state) {
                if (state is DebatLoaded) {
                  final lastMessage = context
                      .read<DebateBloc>()
                      .messages
                      .lastOrNull;
                  if (lastMessage != null && lastMessage.role == 'assistant') {
                    _speak(lastMessage.content);
                  }
                }

                final bloc = context.read<DebateBloc>();
                final hasTyping = state is DebateLoading;
                final currentCount = bloc.messages.length + (hasTyping ? 1 : 0);
                final increased = currentCount > _lastItemCount;
                _lastItemCount = currentCount;

                if (increased) _scrollToBottom();
              },
              builder: (context, state) {
                final bloc = context.read<DebateBloc>();
                final isTyping = state is DebateLoading;
                final items = List<ChatEntity>.from(bloc.messages);

                if (isTyping) {
                  items.add(
                    ChatEntity(
                      role: 'assistant',
                      content: '__typing__',
                      session_id: bloc.currentsession_id,
                    ),
                  );
                }

                if (state is DebateError) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.red.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            state.message,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (items.isNotEmpty) {
                  return ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final m = items[i];
                      if (m.content == '__typing__') {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: TypingBubble(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ChatBubbleWidget(message: m),
                      );
                    },
                  );
                }

                // Empty state
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.forum_outlined,
                            color: AppColor.accent,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Start the Debate',
                          style: TextStyle(
                            color: AppColor.blueDark,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Send a message to begin your discussion\nabout ${widget.topic}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.blueDark.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Input area - menggunakan widget yang sudah diperbaiki
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: MessageInputWidget(
                textController: _textCtrl,
                sendMessage: _handleSend,
                isListening: !_isUserStopped,
                onMicPressed: _isUserStopped
                    ? _startListening
                    : _stopListening,
              ),
            ),
          ),
        ],
      ),
    );
  }
}