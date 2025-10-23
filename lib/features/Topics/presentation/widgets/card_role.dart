import 'package:choach_debate/core/theme/color.dart';
import 'package:flutter/material.dart';

class CardRole extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final String role;

  const CardRole({
    super.key,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    required this.role,
  });

  @override
  State<CardRole> createState() => _CardRoleState();
}

class _CardRoleState extends State<CardRole> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark; // support dark mode

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : Colors.white.withOpacity(0.9),
          boxShadow: [
            if (!_isPressed)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(2, 3),
                blurRadius: 6,
              ),
            if (!_isPressed)
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                offset: const Offset(-2, -2),
                blurRadius: 6,
              ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapCancel: () => setState(() => _isPressed = false),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onTap();
          },
          splashColor: widget.iconColor.withOpacity(0.15),
          highlightColor: Colors.transparent,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 120),
            scale: _isPressed ? 0.96 : 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon dengan background lingkaran lembut
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.iconColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.icon, color: widget.iconColor, size: 28),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.role,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
