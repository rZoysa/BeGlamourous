import 'package:be_glamourous/Screens/social_platform_screen/widgets/social_post.dart';
import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:flutter/material.dart';

class SocialPlatformScreen extends StatefulWidget {
  const SocialPlatformScreen({super.key});

  @override
  State<SocialPlatformScreen> createState() => _SocialPlatformScreenState();
}

class _SocialPlatformScreenState extends State<SocialPlatformScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SocialPost(),
        ],
      ),
    );
  }
}