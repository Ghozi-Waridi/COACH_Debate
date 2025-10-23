import 'package:choach_debate/core/theme/color.dart';
import 'package:flutter/material.dart';

class MessageInputWidget extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback sendMessage;
  final bool isListening;
  final VoidCallback onMicPressed;

  const MessageInputWidget({
    super.key,
    required this.textController,
    required this.sendMessage,
    required this.isListening,
    required this.onMicPressed,
  });

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: AppColor.background.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Mic Button dengan warna yang jelas
            Container(
              decoration: BoxDecoration(
                color: widget.isListening ? Colors.red : AppColor.accent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: widget.onMicPressed,
                icon: Icon(
                  widget.isListening ? Icons.mic_off : Icons.mic,
                  color: Colors.white,
                  size: 20,
                ),
                padding: const EdgeInsets.all(10),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Text Field
            Expanded(
              child: TextField(
                controller: widget.textController,
                style: TextStyle(
                  color: AppColor.blueDark,
                  fontSize: 16,
                ),
                cursorColor: AppColor.accent,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  hintText: 'Ketik Argument Anda...',
                  hintStyle: TextStyle(
                    color: AppColor.blueDark.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  filled: false,
                ),
                onSubmitted: (_) => widget.sendMessage(),
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Send Button
            Container(
              decoration: BoxDecoration(
                color: AppColor.purpleLight,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: widget.sendMessage,
                padding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}