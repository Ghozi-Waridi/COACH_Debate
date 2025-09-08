import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        iconSize: 28,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.purple,
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
        items: [],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
    String label,
    IconData icon,
    bool isSelected,
  ) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
