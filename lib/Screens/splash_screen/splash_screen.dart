import 'package:be_glamourous/Screens/home_screen/home_page.dart';
import 'package:be_glamourous/Screens/landing_screen/landing_page.dart';
import 'package:be_glamourous/utils/navigation/custom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkSessionAndNavigate();
  }

  Future<void> _checkSessionAndNavigate() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate loading time

    String? token = await _storage.read(key: 'jwt');
    bool hasExpired = true;

    if (token != null) {
      hasExpired = JwtDecoder.isExpired(token);
    }

    if (!hasExpired) {
      // If token exists and is not expired, session is valid
      _navigateToHome();
    } else {
      // No valid token found, go to landing page
      _navigateToLanding();
    }
  }

  void _navigateToHome() {
    if (mounted) {
      Customnavigation.nextPage(context, const HomePage());
    }
  }

  void _navigateToLanding() {
    if (mounted) {
      Customnavigation.nextPage(context, const LandingPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 46, 46, 46),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/Logo-Design-Dark.png'), // Logo
              const SizedBox(height: 20),
              const CupertinoActivityIndicator(
                color: Colors.white,
              ), // Optional: Show loading indicator
            ],
          ),
        ),
      ),
    );
  }
}
