import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 14, bottom: 12),
      color: const Color.fromARGB(60, 0, 0, 0),
      child: const SafeArea(
        child: Text(
          'Be Glamourous',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Jura',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
// AppBar(
//         toolbarHeight: 60,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         title: const Text(
//           'Be Glamourous',
//           style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Jura',
//               fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color.fromARGB(0, 145, 24, 24),
//       ),