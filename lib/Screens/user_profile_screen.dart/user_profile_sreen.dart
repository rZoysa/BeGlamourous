import 'package:be_glamourous/Screens/user_profile_screen.dart/widgets/user_profile_app_bar.dart';
import 'package:flutter/material.dart';

class UserProfileSreen extends StatefulWidget {
  const UserProfileSreen({super.key});

  @override
  State<UserProfileSreen> createState() => _UserProfileSreenState();
}

class _UserProfileSreenState extends State<UserProfileSreen> {
  final List<String> buttonText = const [
    'Your Details',
    'Your analyzes',
    'App settings',
    'Support',
    'Terms and conditions'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const UserProfileAppBar(),
          const SizedBox(height: 50),
          ListView.builder(
            shrinkWrap: true,
            itemCount: buttonText.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(76, 153, 153, 153),
                      ),
                      minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 50),
                      ),
                      elevation: const WidgetStatePropertyAll(0),
                      shape: const WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          buttonText[index],
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Jura',
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              );
            },
          ),
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                const Color.fromARGB(76, 153, 153, 153),
              ),
              minimumSize: WidgetStateProperty.all(
                const Size(double.infinity, 50),
              ),
              elevation: const WidgetStatePropertyAll(0),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
              ),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Jura',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
