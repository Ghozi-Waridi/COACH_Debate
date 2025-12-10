import 'package:choach_debate/core/theme/color.dart';
import 'package:choach_debate/features/History/domain/entities/history_entity.dart';
import 'package:choach_debate/features/Debate/domain/entities/chat_entity.dart';
import 'package:choach_debate/features/Debate/presentation/pages/chat_page.dart';
import 'package:choach_debate/features/History/presentation/bloc/history_bloc.dart';
import 'package:choach_debate/shared/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryItemCard extends StatelessWidget {
  final HistoryEntity item;
  final int index;

  const HistoryItemCard({super.key, required this.item, required this.index});

  Color _getCardColor(int index) {
    final colors = [
      AppColor.accent,
      AppColor.blueDark,
      AppColor.purpleLight,
      const Color(0xFF0E8388), // Teal dark
      const Color(0xFFCB6040), // Orange muted
      const Color(0xFF2E4F4F), // Dark cyan
    ];
    return colors[index % colors.length];
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Baru saja';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m lalu';
    if (difference.inHours < 24) return '${difference.inHours}j lalu';
    if (difference.inDays < 7) return '${difference.inDays}h lalu';
    if (difference.inDays < 30)
      return '${(difference.inDays / 7).floor()}mg lalu';
    return '${(difference.inDays / 30).floor()}bln lalu';
  }

  DateTime? _getTimestampFromHistory() {
    if (item.history.isEmpty) return null;
    try {
      final firstMessage = item.history.first;
      final timestampString = firstMessage['timestamp'];
      if (timestampString != null && timestampString.isNotEmpty) {
        return DateTime.parse(timestampString);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  void _navigateToDebate(BuildContext context) {
    // Convert history to ChatEntity list
    final chatMessages = item.history.map((msg) {
      return ChatEntity(
        role: msg['role'] ?? '',
        content: msg['content'] ?? '',
        session_id: item.session_id,
      );
    }).toList();

    // Extract role dari pesan pertama jika ada
    String role = 'Pro'; // Default
    if (item.history.isNotEmpty) {
      final firstContent = item.history.first['content'] ?? '';
      if (firstContent.contains('Kontra')) {
        role = 'Kontra';
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          topic: item.topic,
          role: role,
          sessionId: item.session_id,
          existingMessages: chatMessages,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColor.purpleLight,
                size: 28,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  'Hapus Riwayat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColor.blueDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apakah Anda yakin ingin menghapus riwayat debat ini?',
                style: TextStyle(fontSize: 16, color: AppColor.blueDark),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.accent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.topic,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.blueDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${item.session_id}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.blueDark.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tindakan ini tidak dapat dibatalkan.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.purpleLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Batal',
                style: TextStyle(
                  color: AppColor.blueDark.withOpacity(0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                // Show loading message
                SnackbarUtils.showInfo(context, 'Menghapus riwayat...');

                // Trigger delete event
                context.read<HistoryBloc>().add(
                  DeleteHistoryEvent(item.session_id),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.purpleLight,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getCardColor(index);
    final timestamp = _getTimestampFromHistory();
    final timeAgo = timestamp != null
        ? _getTimeAgo(timestamp)
        : 'Waktu tidak diketahui';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        elevation: 3,
        shadowColor: cardColor.withOpacity(0.4),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToDebate(context),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cardColor, cardColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned(
                  top: -10,
                  right: -10,
                  child: Icon(
                    Icons.forum_rounded,
                    size: 80,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header dengan waktu dan delete button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      timeAgo,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Delete button
                              InkWell(
                                onTap: () {
                                  _showDeleteConfirmation(context);
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Topik debat
                      Text(
                        item.topic,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 12),

                      // Session ID dan info tambahan
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID Sesi',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.session_id,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  size: 10,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    '${item.history.length} pesan',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
