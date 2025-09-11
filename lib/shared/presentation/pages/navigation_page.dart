import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:choach_debate/shared/presentation/widgets/custom_navigation_widget.dart';

class NavigationPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final GlobalKey<ScaffoldState> navigatorKey;
  const NavigationPage({
    super.key,
    required this.navigationShell,
    required this.navigatorKey,
  });

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    void goTobranch(int index) {
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: widget.navigationShell,
      bottomNavigationBar: CustomNavigationWidget(
        navigationShell: widget.navigationShell,
        goToBranch: goTobranch,
      ),
    );
  }
}
