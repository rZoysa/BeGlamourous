import 'package:be_glamourous/Screens/landing_screen/landing_page.dart';
import 'package:be_glamourous/Screens/user_profile_screen.dart/widgets/user_profile_app_bar.dart';
import 'package:be_glamourous/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileSreen extends StatefulWidget {
  const UserProfileSreen({super.key});

  @override
  State<UserProfileSreen> createState() => _UserProfileSreenState();
}

class _UserProfileSreenState extends State<UserProfileSreen> {
  final List<String> buttonText = const [
    // 'Your Details',
    // 'Your analyzes',
    // 'App settings',
    'Support',
    'Terms and conditions'
  ];

  void logoutUser() async {
    await secureStorage.delete(
      key: 'jwt',
    ); //Delete the token from the secure storage

    await secureStorage.deleteAll();

    if (mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const UserProfileAppBar(),
          const SizedBox(height: 50),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      elevation: 1,
                      title: const Icon(
                        CupertinoIcons.exclamationmark_circle,
                        color: Colors.red,
                        size: 48,
                      ),
                      content: const Text(
                        'Confirm Logout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Jura',
                            fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xFFBCBCBC),
                                        )),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Jura',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextButton(
                                onPressed: logoutUser,
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xFFBCBCBC),
                                        )),
                                  ),
                                ),
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      fontFamily: 'Jura',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  });
            },
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
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
