import 'package:be_glamourous/Screens/main_screen/main_screen.dart';
import 'package:be_glamourous/Screens/skin_analyzer_screen/skin_analyzer_page.dart';
import 'package:be_glamourous/Screens/social_platform_screen/social_platform_screen.dart';
import 'package:be_glamourous/Screens/user_profile_screen.dart/user_profile_sreen.dart';
import 'package:be_glamourous/components/custom_nav_bar.dart';
import 'package:be_glamourous/providers/screen_change_provider.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MainScreen(),
    const SkinAnalyzerPage(),
    const SocialPlatformScreen(),
    const UserProfileSreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Provider.of<ScreenChangeProvider>(context, listen: false)
          .setScreenId(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromARGB(255, 100, 100, 100);

    return Scaffold(
      body: Container(
        decoration: DecorationHelper.backgroundDecoration(),
        child: Stack(
          children: [
            SafeArea(
              child: IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedNavigationBar(
                height: 55,
                animationDuration: const Duration(milliseconds: 400),
                color: const Color.fromARGB(255, 243, 243, 243),
                buttonBackgroundColor: const Color(0xFFD1A55C),
                animationCurve: Curves.ease,
                backgroundColor: Colors.transparent,
                items: const <Widget>[
                  Icon(Icons.home, size: 30, color: iconColor),
                  Icon(Icons.donut_small_rounded, size: 30, color: iconColor),
                  Icon(Icons.groups_2_rounded, size: 30, color: iconColor),
                  Icon(Icons.menu, size: 30, color: iconColor),
                ],
                onTap: _onItemTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
