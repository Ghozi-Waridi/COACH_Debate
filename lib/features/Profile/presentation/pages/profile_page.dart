import 'package:choach_debate/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'dart:ui';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import 'package:choach_debate/features/Profile/presentation/widgets/list_secsion_widget.dart';
import 'package:choach_debate/features/Profile/presentation/bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1506744038136-46273834b3fb'
              '?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA'
              '%3D%3D&auto=format&fit=crop&w=1470&q=80',
              fit: BoxFit.cover,
            ),
          ),

          //
          // Positioned.fill(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          //     child: Container(color: Colors.black.withOpacity(0.4)),
          //   ),
          // ),
          SafeArea(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                print(" State : ${state.toString()}");
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProfileError) {
                  return Center(child: Text("Error: ${state.message}"));
                }

                if (state is ProfileLoaded) {
                  final profile = state.profile;
                  print(state.profile.userName);

                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(16.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            Align(
                              alignment: Alignment.center,
                              child: FractionallySizedBox(
                                widthFactor: 0.5,
                                child: LiquidGlass(
                                  shape: LiquidRoundedSuperellipse(
                                    borderRadius: const Radius.circular(40),
                                  ),
                                  settings: LiquidGlassSettings(
                                    thickness: 12,
                                    lightAngle: 0.5 * pi,
                                    blend: 60,
                                    chromaticAberration: 1.2,
                                    lightIntensity: 1.2,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const CircleAvatar(
                                          radius: 60,
                                          // backgroundImage: AssetImage(
                                          //   '',
                                          // ),
                                          backgroundColor: Colors.grey,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          profile.userName,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          profile.email,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          profile.institusi,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Settings Card
                            LiquidGlass(
                              shape: LiquidRoundedRectangle(
                                borderRadius: const Radius.circular(30),
                              ),
                              settings: LiquidGlassSettings(
                                thickness: 12,
                                lightAngle: 0.5 * pi,
                                blend: 60,
                                chromaticAberration: 1.2,
                                lightIntensity: 1.2,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    ListSecsionWidget(
                                      icon: Icons.person,
                                      title: 'Profile',
                                      subtitle: 'View and edit your profile',
                                      iconColor: Colors.blue,
                                      ontap: () {
                                        // Contoh trigger update
                                        context.read<ProfileBloc>().add(
                                          UpdateProfilePressed(
                                            name: "New Name",
                                            email: profile.email,
                                            institusi: profile.institusi,
                                          ),
                                        );
                                      },
                                    ),
                                    Divider(color: Colors.grey.shade300),
                                    ListSecsionWidget(
                                      icon: Icons.settings,
                                      title: 'Settings',
                                      subtitle: 'App settings and preferences',
                                      iconColor: Colors.green,
                                      ontap: () {},
                                    ),
                                    Divider(color: Colors.grey.shade300),
                                    ListSecsionWidget(
                                      icon: Icons.notifications,
                                      title: 'Notifications',
                                      subtitle: 'Manage notification settings',
                                      iconColor: Colors.orange,
                                      ontap: () {},
                                    ),
                                    Divider(color: Colors.grey.shade300),
                                    // 🔴 Tombol Logout
                                    ListSecsionWidget(
                                      icon: Icons.logout,
                                      title: 'Logout',
                                      subtitle: 'Keluar dari akun ini',
                                      iconColor: Colors.red,
                                      ontap: () {
                                        context.read<AuthBloc>().add(
                                          LogoutPressed(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                          ]),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        fillOverscroll: true,
                        child: Container(),
                      ),
                    ],
                  );
                }

                return const Center(
                  child: Text("Press button to load profile"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
