import 'package:flutter/material.dart';

class UserProfileAppBar extends StatefulWidget implements PreferredSizeWidget {
  const UserProfileAppBar({super.key});

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(280);
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 14, bottom: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        color: Color.fromARGB(60, 0, 0, 0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
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
          ),
          const SizedBox(height: 15),
          Image.asset(
            'assets/images/default_profile_icon.png',
            alignment: Alignment.center,
          ),
          const SizedBox(height: 15),
          const Text(
            'John Doe',
            style: TextStyle(
              fontFamily: 'Jura',
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          const Text(
            'johndoe@email.com',
            style: TextStyle(
              fontFamily: 'Jura',
              fontSize: 18,
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}
