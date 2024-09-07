import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationHelper.backgroundDecoration(),
      child: Theme(
        data: ThemeData(colorScheme: const ColorScheme.dark()),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Terms and Conditions',
              style: TextStyle(
                fontFamily: 'Jura',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Please read these terms and conditions carefully before using the app. By accessing and using the Be Glamourous app, you agree to be bound by these terms.',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '1. Acceptance of Terms',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'By using this app, you agree to comply with and be bound by these terms of service.',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '2. User Responsibilities',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You are responsible for maintaining the confidentiality of your account and password.',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '3. Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your personal data will be used in accordance with our privacy policy.',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 18,
                    ),
                  ),
                  // Add more terms as needed...
                  SizedBox(height: 20),
                  Text(
                    'For more details, please refer to the complete terms and conditions.',
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
