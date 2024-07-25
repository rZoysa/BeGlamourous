import 'package:be_glamourous/components/custom_nav_bar.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> pages = const [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: DecorationHelper.backgroundDecoration(),
          child: Stack(
            children: [
              SafeArea(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: pages,
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
                    Icon(Icons.home, size: 30, color: Colors.black),
                    Icon(Icons.settings, size: 30, color: Colors.black,),
                    // Icon(Icons.compare_arrows, size: 30, color: Colors.black),
                    // Icon(Icons.settings, size: 30, color: Colors.black),
                  ],
                  onTap: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                ),
              ),
            ],
          )),
    );
  }
}
