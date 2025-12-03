import 'package:choach_debate/features/Topics/presentation/widgets/topic_tile.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final dynamic topic;

  const TopicCard({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    // Use the styled TopicTile directly to avoid double card layers.
    return TopicTile(topic: topic);
  }
}
