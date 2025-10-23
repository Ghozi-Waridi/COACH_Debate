import 'package:choach_debate/core/theme/color.dart';
import 'package:choach_debate/features/Analis/presentation/widgets/card_item_widget.dart';
import 'package:choach_debate/features/Analis/presentation/widgets/card_session_widget.dart';
import 'package:flutter/material.dart';

class AnalisPage extends StatelessWidget {
  const AnalisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          'Analisis Debat',
          style: TextStyle(
            color: AppColor.blueDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.blueDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColor.accent.withOpacity(0.1),
                    child: Icon(
                      Icons.analytics,
                      size: 40,
                      color: AppColor.accent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Analisis Performa Debat',
                    style: TextStyle(
                      color: AppColor.blueDark,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tinjau dan tingkatkan kemampuan debat Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.blueDark.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Ringkasan Statistik',
              style: TextStyle(
                color: AppColor.blueDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CardItemWidget(
                    title: 'Sesi Selesai',
                    value: '12',
                    icon: Icons.assignment_turned_in,
                    color: AppColor.accent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CardItemWidget(
                    title: 'Skor Rata-rata',
                    value: '8.2',
                    icon: Icons.star,
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
                    value: '5',
                    icon: Icons.emoji_events,
                    color: AppColor.blueDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CardItemWidget(
                    title: 'Waktu Total',
                    value: '6h 30m',
                    icon: Icons.timer,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              'Sesi Terbaru',
              style: TextStyle(
                color: AppColor.blueDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              height: 400,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  CardSessionWidget(
                    topic: 'Debat Politik - Isu Kebijakan Luar Negeri',
                    score: '8.5',
                    duration: '30 menit',
                    date: DateTime.now().subtract(const Duration(days: 1)),
                  ),
                  CardSessionWidget(
                    topic: 'Isu Lingkungan - Perubahan Iklim Global',
                    score: '7.8',
                    duration: '25 menit',
                    date: DateTime.now().subtract(const Duration(days: 3)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
