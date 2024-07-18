import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: DecorationHelper.backgroundDecoration(),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 173, 173, 173),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
