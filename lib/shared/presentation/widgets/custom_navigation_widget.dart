import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class CustomNavigationWidget extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final void Function(int) goToBranch;
  const CustomNavigationWidget({
    super.key,
    required this.navigationShell,
    required this.goToBranch,
  });

  @override
  Widget build(BuildContext context) {
    final int currentIndex = navigationShell.currentIndex;
    return Container(
      margin: EdgeInsets.all(16.0),

      child: LiquidGlass(
        shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(50.0)),
        settings: LiquidGlassSettings(
          thickness: 12,
          lightAngle: 0.5 * pi,
          blend: 60,
          chromaticAberration: 1.2,
          lightIntensity: 1.2,
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BottomNavigationBar(
                iconSize: 28,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                backgroundColor: Colors.transparent,
                currentIndex: currentIndex,
                selectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                onTap: (index) {
                  goToBranch(index);
                },
                items: [
                  _bottomNavigationBarItem(
                    'Home',
                    Icons.home,
                    currentIndex == 0,
                  ),
                  _bottomNavigationBarItem(
                    'Analis',
                    Icons.newspaper,
                    currentIndex == 1,
                  ),
                  _bottomNavigationBarItem(
                    'Profile',
                    Icons.person,
                    currentIndex == 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
    String label,
    IconData icon,
    bool isSelected,
  ) {
    return BottomNavigationBarItem(
      icon: AnimatedScale(
        duration: const Duration(milliseconds: 250),
        scale: isSelected ? 1.3 : 1.0,
        child: SizedBox(
          width: 50,
          height: 50,
          child: LiquidGlass(
            shape: const LiquidRoundedSuperellipse(
              borderRadius: Radius.circular(20.0),
            ),
            settings: LiquidGlassSettings(
              thickness: 8,
              lightAngle: 0.5 * pi,
              blend: 50,
              chromaticAberration: 1.0,
              lightIntensity: 1.1,
            ),
            child: Center(
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 35,
              ),
            ),
          ),
        ),
      ),
      label: label,
    );
  }
}
