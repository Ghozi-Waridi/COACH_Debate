import 'dart:ui';
import 'package:choach_debate/core/theme/color.dart';
import 'package:choach_debate/features/Analis/presentation/bloc/analis_bloc.dart';
import 'package:choach_debate/features/Analis/presentation/bloc/analis_event.dart';
import 'package:choach_debate/features/Analis/presentation/bloc/analis_state.dart';
import 'package:choach_debate/features/Analis/presentation/widgets/card_item_widget.dart';
import 'package:choach_debate/features/Analis/presentation/widgets/card_session_widget.dart';
import 'package:choach_debate/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisPage extends StatefulWidget {
  const AnalisPage({super.key});

  @override
  State<AnalisPage> createState() => _AnalisPageState();
}

class _AnalisPageState extends State<AnalisPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AnalisBloc>()..add(const LoadAnalisDataEvent()),
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: Stack(
          children: [
            // Gradient background dengan blur circles
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColor.accent.withOpacity(0.3),
                      AppColor.accent.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -100,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecimal(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColor.purpleLight.withOpacity(0.2),
                      AppColor.purpleLight.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: BlocBuilder<AnalisBloc, AnalisState>(
                  builder: (context, state) {
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        // Custom App Bar dengan blur effect
                        SliverAppBar(
                          expandedHeight: 120,
                          floating: true,
                          pinned: true,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          flexibleSpace: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(0.8),
                                      Colors.white.withOpacity(0.6),
                                    ],
                                  ),
                                ),
                                child: FlexibleSpaceBar(
                                  centerTitle: false,
                                  titlePadding: const EdgeInsets.only(
                                    left: 20,
                                    bottom: 16,
                                  ),
                                  title: Text(
                                    'Analisis Debat',
                                    style: TextStyle(
                                      color: AppColor.blueDark,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Content
                        SliverPadding(
                          padding: const EdgeInsets.all(20),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              _buildHeroCard(),
                              const SizedBox(height: 32),
                              _buildSectionTitle('Ringkasan Statistik'),
                              const SizedBox(height: 16),
                              if (state is AnalisLoading)
                                const Center(child: CircularProgressIndicator())
                              else if (state is AnalisError)
                                Center(
                                  child: Text(
                                    state.message,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              else if (state is AnalisLoaded)
                                _buildStatsGrid(state.analytics)
                              else
                                _buildStatsGrid(null),
                              const SizedBox(height: 32),
                              _buildSectionTitle('Sesi Terbaru'),
                              const SizedBox(height: 16),
                              if (state is AnalisLoading)
                                const Center(child: CircularProgressIndicator())
                              else if (state is AnalisError)
                                Center(
                                  child: Text(
                                    'Gagal memuat data',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              else if (state is AnalisLoaded)
                                _buildSessionsList(state.recentSessions)
                              else
                                _buildSessionsList([]),
                            ]),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.accent.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColor.accent, AppColor.blueDark],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.accent.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.analytics_rounded,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Analisis Performa Debat',
                style: TextStyle(
                  color: AppColor.blueDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tinjau dan tingkatkan kemampuan debat Anda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.blueDark.withOpacity(0.6),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColor.blueDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildStatsGrid(analytics) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CardItemWidget(
                title: 'Sesi Selesai',
                value: analytics?.totalSessions.toString() ?? '0',
                icon: Icons.assignment_turned_in_rounded,
                color: AppColor.accent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CardItemWidget(
                title: 'Skor Rata-rata',
                value: analytics?.averageScore.toStringAsFixed(1) ?? '0.0',
                icon: Icons.star_rounded,
                color: AppColor.purpleLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CardItemWidget(
                title: 'Topik Dikuasai',
                value: analytics?.masteredTopics.toString() ?? '0',
                icon: Icons.emoji_events_rounded,
                color: AppColor.blueDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CardItemWidget(
                title: 'Waktu Total',
                value: analytics?.totalTime ?? '0h 0m',
                icon: Icons.timer_rounded,
                color: const Color(0xFF2E8B57),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSessionsList(List sessions) {
    if (sessions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Belum ada sesi debat',
            style: TextStyle(
              color: AppColor.blueDark.withOpacity(0.5),
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Column(
      children: sessions.map((session) {
        return CardSessionWidget(
          topic: session.topic,
          score: session.score.toStringAsFixed(1),
          duration: session.duration,
          date: session.date,
        );
      }).toList(),
    );
  }
}

// Fix typo BoxDecimal → BoxDecoration
class BoxDecimal extends BoxDecoration {
  const BoxDecimal({super.shape, super.gradient});
}
