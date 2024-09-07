import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationHelper.backgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Support',
            style: TextStyle(
              fontFamily: 'Jura',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Need Help?',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Jura',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'For any issues or queries, feel free to contact our support team at:',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Jura',
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'support@be-glamourous.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Jura',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Or call us at:',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Jura',
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    '+123 456 789',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Jura',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
