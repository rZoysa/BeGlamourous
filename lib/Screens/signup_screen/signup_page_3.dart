import 'package:be_glamourous/Screens/signup_screen/widgets/skin_type_buttons.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';

class SignupPage3 extends StatefulWidget {
  const SignupPage3({super.key});

  @override
  State<SignupPage3> createState() => _SignupPage3State();
}

class _SignupPage3State extends State<SignupPage3> {
  @override
  Widget build(BuildContext context) {
    final textFieldLabelStyle = TextStyle(
      fontSize: 28,
      color: Theme.of(context).colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: Container(
        decoration: DecorationHelper.backgroundDecoration(),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Your Skin Type',
                      style: textFieldLabelStyle,
                    ),
                    const Column(
                      children: [Skintypebuttons()],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Text(
                        'Back',
                        style: DecorationHelper.buttonTextStyle(),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          elevation: 0,
                          minimumSize: const Size.square(65),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(55),
                            ),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: DecorationHelper.buttonTextStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
