import 'package:be_glamourous/Screens/user_profile_screen.dart/widgets/user_profile_app_bar.dart';
import 'package:flutter/material.dart';

class UserProfileSreen extends StatefulWidget {
  const UserProfileSreen({super.key});

  @override
  State<UserProfileSreen> createState() => _UserProfileSreenState();
}

class _UserProfileSreenState extends State<UserProfileSreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          UserProfileAppBar()          
        ],
      ),
    );
  }
}