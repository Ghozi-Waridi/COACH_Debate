import 'package:choach_debate/features/Topics/presentation/widgets/empty_state.dart';
import 'package:choach_debate/features/Topics/presentation/widgets/loading_silver_list_skeleton.dart';
import 'package:choach_debate/features/Topics/presentation/widgets/topic_card.dart';
import 'package:flutter/material.dart';

class TopicList extends StatelessWidget {
  final List<dynamic>? topics;
  final bool isLoading;
  final String? selectedCategory;
  final String searchQuery;
  final int? lastTopicCount;

  const TopicList({
    super.key,
    required this.topics,
    required this.isLoading,
    required this.selectedCategory,
    required this.searchQuery,
    this.lastTopicCount,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && selectedCategory != null) {
      return LoadingSliverListSkeleton(topicCount: lastTopicCount ?? 6);
    }

    final q = searchQuery.trim().toLowerCase();
    final filtered = (topics ?? const <dynamic>[])
        .where((t) => (t.topic as String).toLowerCase().contains(q))
        .toList();

    if (filtered.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          title: 'Topik tidak ditemukan',
          subtitle: q.isNotEmpty
              ? 'Coba kata kunci lain atau pilih kategori lain.'
              : 'Belum ada topik di kategori "${selectedCategory ?? ''}".',
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 20),
      sliver: SliverList.separated(
        itemCount: filtered.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final topic = filtered[index];
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: 1.0,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 300 + index * 80),
              builder: (context, value, child) =>
                  Transform.scale(scale: value, child: child),
              child: TopicCard(topic: topic),
            ),
          );
        },
      ),
    );
  }
}
