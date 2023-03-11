import 'package:flutter/material.dart';

class SplashText extends StatelessWidget {
  final String text;
  final double fontSize;
  const SplashText({required this.fontSize, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return (Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSize),
    ));
  }
}
