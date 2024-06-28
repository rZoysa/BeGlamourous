import 'package:be_glamourous/Screens/landing_screen/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'KaiseiDecol',
        colorScheme: ColorScheme.fromSeed(
          primary: const Color.fromRGBO(38, 41, 45, 1),
          seedColor: const Color.fromARGB(255, 255, 255, 255),
          secondary: const Color.fromRGBO(209, 165, 92, 1),
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
