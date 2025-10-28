import 'package:choach_debate/core/theme/color.dart';
import 'package:choach_debate/features/Home/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:choach_debate/core/router/app_router_enum.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:choach_debate/features/Profile/presentation/bloc/profile_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.forum_rounded, color: AppColor.accent, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'CoachDebate',
                    style: TextStyle(
                      color: AppColor.accent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
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
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        String userName = 'User'; // Default fallback

                        if (state is ProfileLoaded) {
                          userName = state.profile.userName;
                        }

                        return Column(
                          children: [
                            Text(
                              'Selamat Datang, $userName!',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineLarge?.copyWith(
                                color: AppColor.blueDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tingkatkan kemampuan berdebat Anda.\nSiap untuk memulai sesi?',
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                color: AppColor.blueDark.withOpacity(0.8),
                                height: 1.5,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CardWidget(
                        title: 'Sesi',
                        value: '12',
                        icon: Icons.assignment,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(AppRouterEnum.topicsScreen.name);
                        },
                        child: CardWidget(
                          title: 'Topik',
                          value: '8',
                          icon: Icons.topic,
                        ),
                      ),
                      CardWidget(
                        title: 'Level',
                        value: 'Intermediate',
                        icon: Icons.star,
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                children: [
                  ScaleTransition(
                    scale: _animation,
                    child: GestureDetector(
                      onTap: () {
                        context.goNamed(AppRouterEnum.topicsScreen.name);
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.purpleLight,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.purpleLight.withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tap untuk mulai debat',
                    style: TextStyle(
                      color: AppColor.blueDark.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
