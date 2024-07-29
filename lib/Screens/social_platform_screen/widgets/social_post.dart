import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialPost extends StatefulWidget {
  const SocialPost({super.key});

  @override
  State<SocialPost> createState() => _SocialPostState();
}

class _SocialPostState extends State<SocialPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(10, 255, 255, 255),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/default_profile_icon.png',
                    alignment: Alignment.center,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jura',
                        ),
                      ),
                      Text(
                        '24 Jul 2024',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Jura',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Text(
            'Caption',
            style: TextStyle(
              fontFamily: 'Jura',
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      Icons.thumb_up_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Like',
                      style: TextStyle(fontFamily: 'Jura', color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      CupertinoIcons.chat_bubble_fill,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Comment',
                      style: TextStyle(fontFamily: 'Jura', color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
