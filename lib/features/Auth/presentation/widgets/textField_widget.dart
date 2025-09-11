import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:math';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class TextfieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  bool obscureText;
  final IconData icon;
  IconData? suffixIcon;
  TextInputType? keyboardType;

  TextfieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: LiquidGlass(
          shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(12)),
          settings: LiquidGlassSettings(
            thickness: 12,
            lightAngle: 0.5 * pi,
            blend: 60,
            chromaticAberration: 1.2,
            lightIntensity: 1.2,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  offset: Offset(-1, -1),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(1, 1),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: TextField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  widget.icon,
                  color: Colors.white.withOpacity(0.8),
                  size: 20,
                ),
                // suffixIcon: suffixIcon != null
                //     ? Icon(
                //         suffixIcon,
                //         color: Colors.white.withOpacity(0.8),
                //         size: 20,
                //       )
                //     : null,
                suffixIcon: widget.suffixIcon != null
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            widget.obscureText = !widget.obscureText;
                          });
                        },
                        icon: Icon(
                          widget.obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.white.withOpacity(0.8),
                          size: 20,
                        ),
                      )
                    : null,

                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                filled: false,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
