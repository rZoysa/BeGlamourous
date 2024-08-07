import 'package:be_glamourous/Screens/landing_screen/landing_page.dart';
import 'package:be_glamourous/utils/navigation/custom_navigation.dart';
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
    await Future.delayed(const Duration(seconds: 1), () {});

    // Check if the widget is still mounted before navigating
    if (mounted) {
      Customnavigation.nextPage(context, const LandingPage());
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
            Image.asset('assets/images/Logo-Design-Dark.png'), //Logo
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
