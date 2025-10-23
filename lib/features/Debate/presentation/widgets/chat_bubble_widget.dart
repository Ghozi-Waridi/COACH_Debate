import 'package:choach_debate/core/theme/color.dart';
import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';
import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatEntity message;
  const ChatBubbleWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isUserMessage = message.role == 'user';
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUserMessage ? AppColor.purpleLight : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isUserMessage ? const Radius.circular(20) : const Radius.circular(4),
            bottomRight: isUserMessage ? const Radius.circular(4) : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: isUserMessage ? null : Border.all(
            color: AppColor.background.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: isUserMessage ? Colors.white : AppColor.blueDark,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}