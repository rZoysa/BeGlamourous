import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(10, 255, 255, 255),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skin care 101',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Divider(
            color: Color.fromARGB(155, 0, 0, 0),
            thickness: 2,
          ),
          Text(
            '1. Get the order right.\n'
            '2. Exfoliate once per week.\n'
            '3. Always wear an SPF.\n'
            '4. Drink water, and lots of it.\n'
            '5. Don’t forget your neck and décolletage.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
