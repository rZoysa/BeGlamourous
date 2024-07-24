import 'package:be_glamourous/Screens/home_screen/home_page.dart';
import 'package:be_glamourous/Screens/landing_screen/landing_page.dart';
import 'package:be_glamourous/Screens/splash_screen/splash_screen.dart';
import 'package:be_glamourous/providers/user_signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserSignupProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/landing': (context) => const LandingPage(),
          '/home': (context) => const HomePage(),
        },
        theme: ThemeData(
          fontFamily: 'KaiseiDecol',
          colorScheme: ColorScheme.fromSeed(
            primary: const Color.fromRGBO(38, 41, 45, 1),
            seedColor: const Color.fromARGB(255, 255, 255, 255),
            secondary: const Color.fromRGBO(209, 165, 92, 1),
          ),
          useMaterial3: true,
        ),
        // home: const LandingPage(),
      ),
    );
  }
}
