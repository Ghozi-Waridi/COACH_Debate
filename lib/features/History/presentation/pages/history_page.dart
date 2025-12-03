import 'package:choach_debate/core/theme/color.dart';
import 'package:choach_debate/features/History/domain/entities/history_entity.dart';
import 'package:choach_debate/features/History/presentation/bloc/history_bloc.dart';
import 'package:choach_debate/features/History/presentation/widgets/HistoryItemCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 300 && !_showScrollToTop) {
      setState(() => _showScrollToTop = true);
    } else if (_scrollController.offset <= 300 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  /// Helper function untuk extract timestamp dari history entry
  DateTime? _getTimestampFromHistory(HistoryEntity entry) {
    if (entry.history.isEmpty) return null;

    try {
      final firstMessage = entry.history.first;
      final timestampString = firstMessage['timestamp'];
      if (timestampString != null && timestampString.isNotEmpty) {
        return DateTime.parse(timestampString);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  /// Helper function untuk grouping history berdasarkan tanggal
  Map<String, List<HistoryEntity>> _groupHistoryByDate(
    List<HistoryEntity> entries,
  ) {
    final Map<String, List<HistoryEntity>> grouped = {};
    final now = DateTime.now();
    final today = DateUtils.dateOnly(now);
    final yesterday = DateUtils.dateOnly(now.subtract(const Duration(days: 1)));

    for (final entry in entries) {
      final timestamp = _getTimestampFromHistory(entry);

      if (timestamp == null) {
        const dateKey = 'Tanpa Tanggal';
        grouped.putIfAbsent(dateKey, () => []).add(entry);
        continue;
      }

      final entryDate = DateUtils.dateOnly(timestamp);
      String dateKey;

      if (entryDate == today) {
        dateKey = 'Hari Ini';
      } else if (entryDate == yesterday) {
        dateKey = 'Kemarin';
      } else {
        dateKey = DateFormat('d MMMM yyyy').format(timestamp);
      }

      grouped.putIfAbsent(dateKey, () => []).add(entry);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan tema konsisten
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.history_rounded,
                        color: AppColor.accent,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Riwayat Debat",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColor.blueDark,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Telusuri semua sesi debat sebelumnya",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.blueDark.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: BlocBuilder<HistoryBloc, HistoryState>(
                  builder: (context, state) {
                    if (state is HistoryLoading) {
                      return _buildLoadingState();
                    }

                    if (state is HistoryError) {
                      return _buildErrorState(state.message);
                    }

                    if (state is HistoryLoaded) {
                      if (state.historyEntries.isEmpty) {
                        return _buildEmptyState();
                      }

                      final groupedHistory = _groupHistoryByDate(
                        state.historyEntries,
                      );
                      final dates = groupedHistory.keys.toList();

                      return Stack(
                        children: [
                          NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              return false;
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: dates.length,
                              itemBuilder: (context, index) {
                                final dateString = dates[index];
                                final itemsForDate =
                                    groupedHistory[dateString]!;

                                return _buildDateSection(
                                  dateString,
                                  itemsForDate,
                                  index,
                                );
                              },
                            ),
                          ),

                          // Floating Action Button untuk scroll ke atas
                          if (_showScrollToTop)
                            Positioned(
                              bottom: 20,
                              right: 0,
                              child: FloatingActionButton(
                                onPressed: _scrollToTop,
                                backgroundColor: AppColor.accent,
                                foregroundColor: Colors.white,
                                elevation: 8,
                                child: const Icon(Icons.arrow_upward_rounded),
                              ),
                            ),
                        ],
                      );
                    }

                    return const Center(child: Text('Memuat riwayat...'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.accent),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Memuat riwayat...",
            style: TextStyle(
              fontSize: 16,
              color: AppColor.blueDark.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: AppColor.purpleLight,
          ),
          const SizedBox(height: 16),
          Text(
            "Terjadi Kesalahan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.blueDark,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.blueDark.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<HistoryBloc>().add(GetAllHistoryEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Coba Lagi"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColor.accent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.forum_outlined, size: 60, color: AppColor.accent),
          ),
          const SizedBox(height: 24),
          Text(
            "Belum Ada Riwayat",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.blueDark,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              "Mulai debat pertama Anda dan riwayat akan muncul di sini",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.blueDark.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(
    String dateString,
    List<HistoryEntity> itemsForDate,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header tanggal dengan desain modern
        Container(
          margin: EdgeInsets.only(top: index == 0 ? 0 : 32, bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _getDateHeaderColor(dateString),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getDateIcon(dateString), size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                dateString,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${itemsForDate.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Grid items
        MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: itemsForDate.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, itemIndex) {
            final historyItem = itemsForDate[itemIndex];
            return HistoryItemCard(item: historyItem, index: itemIndex);
          },
        ),
      ],
    );
  }

  Color _getDateHeaderColor(String dateString) {
    switch (dateString) {
      case 'Hari Ini':
        return AppColor.accent;
      case 'Kemarin':
        return AppColor.blueDark;
      case 'Tanpa Tanggal':
        return Colors.grey[600]!;
      default:
        return AppColor.purpleLight;
    }
  }

  IconData _getDateIcon(String dateString) {
    switch (dateString) {
      case 'Hari Ini':
        return Icons.today_rounded;
      case 'Kemarin':
        return Icons.history_rounded;
      case 'Tanpa Tanggal':
        return Icons.schedule_rounded;
      default:
        return Icons.calendar_today_rounded;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
