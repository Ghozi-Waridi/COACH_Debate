import 'package:choach_debate/core/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:choach_debate/core/theme/app_color.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: AppColor.background.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('Home', Icons.home_outlined, Icons.home_filled, 0, currentIndex),
            _buildNavItem('Analytics', Icons.analytics_outlined, Icons.analytics, 1, currentIndex),
            _buildNavItem('Profile', Icons.person_outline, Icons.person, 2, currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String label,
    IconData outlineIcon,
    IconData filledIcon,
    int index,
    int currentIndex,
  ) {
    final bool isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => goToBranch(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isSelected ? _getActiveColor(index) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon dengan animasi
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: isSelected
                  ? Icon(
                      filledIcon,
                      key: ValueKey('filled_$index'),
                      color: Colors.white,
                      size: 24,
                    )
                  : Icon(
                      outlineIcon,
                      key: ValueKey('outline_$index'),
                      color: AppColor.blueDark.withOpacity(0.6),
                      size: 24,
                    ),
            ),
            
            const SizedBox(height: 4),
            
            // Label dengan animasi
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              transform: Matrix4.identity()..scale(isSelected ? 1.0 : 0.85),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : AppColor.blueDark.withOpacity(0.7),
                  letterSpacing: isSelected ? 0.3 : 0.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getActiveColor(int index) {
    switch (index) {
      case 0: // Home
        return AppColor.accent;
      case 1: // Analytics
        return AppColor.purpleLight;
      case 2: // Profile
        return AppColor.blueDark;
      default:
        return AppColor.accent;
    }
  }
}