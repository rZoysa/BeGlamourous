import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});


    // Check if the widget is still mounted before navigating
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/landing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 46, 46, 46),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                'assets/images/Logo-Design-Dark.png'), // Replace with your actual logo
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
