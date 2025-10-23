import 'package:flutter/material.dart';
import 'package:choach_debate/core/theme/color.dart';

class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});

  @override
  State<TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _dot(int index) {
    final curve = CurvedAnimation(
      parent: _c,
      curve: Interval(
        index * 0.15,
        index * 0.15 + 0.70,
        curve: Curves.easeInOut,
      ),
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.3, end: 1.0).animate(curve),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.85, end: 1.15).animate(curve),
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColor.blueDark.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: AppColor.background.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, __) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dot(0),
              const SizedBox(width: 6),
              _dot(1),
              const SizedBox(width: 6),
              _dot(2),
            ],
          ),
        ),
      ),
    );
  }
}