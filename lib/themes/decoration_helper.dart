import 'package:flutter/material.dart';

class DecorationHelper {
  static BoxDecoration backgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(1.5, 0.0),
        end: Alignment(-3.0, 0.0),
        colors: [
          Color(0xFF26292D),
          Color(0xFF575A61),
        ],
        stops: [0.3692, 0.9613],
        transform:
            GradientRotation(64 * 3.1415927 / 90), // 64 degrees in radians
      ),
    );
  }

  static TextStyle buttonTextStyle() {
    return const TextStyle(
      fontSize: 30,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          offset: Offset(3.0, 4.0),
          blurRadius: 10.0,
          color: Color.fromARGB(255, 53, 53, 53),
        ),
      ],
    );
  }
}
