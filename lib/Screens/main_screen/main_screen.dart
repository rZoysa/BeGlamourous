import 'package:be_glamourous/Screens/main_screen/widgets/post.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final double progress = 0.7;
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
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 7.0,
                  color: const Color(0xff92AE1F),
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,                  
                ),
              ),
            ],
          ),
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
                    return const Post();
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
