import 'package:choach_debate/features/Topics/presentation/widgets/topic_tile.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final dynamic topic;

  const TopicCard({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: TopicTile(topic: topic),
      ),
    );
  }
}
