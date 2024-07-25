import 'package:be_glamourous/Screens/main_screen/widgets/post.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    const int itemCount = 4;
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 1,
        scrolledUnderElevation: 0,
        title: const Text(
          'Be Glamourous',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Jura',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(0, 145, 24, 24),
      ),
      body: Column(
        children: [
          Expanded(
            child: Expanded(
              child: ListView.builder(
                itemCount: itemCount + 1,
                itemBuilder: (context, index) {
                  if (index == itemCount) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 80),
                    );
                  } else {
                    return Post();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
