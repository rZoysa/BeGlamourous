import 'package:be_glamourous/Screens/signup_screen/widgets/skin_type_buttons.dart';
import 'package:be_glamourous/providers/user_signup_provider.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage3 extends StatefulWidget {
  const SignupPage3({super.key});

  @override
  State<SignupPage3> createState() => _SignupPage3State();
}

class _SignupPage3State extends State<SignupPage3> {
  String selectedSkinType = '';
  bool showErrMsg = false;

  void _completeSignup(UserSignupProvider signupProvider) async {
    if (selectedSkinType.isEmpty) {
      setState(() {
        showErrMsg = true;
      });
    } else {
      signupProvider.updateSkinType(selectedSkinType);

      bool success = await signupProvider.completeSignup();

      if (!mounted) return;

      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Show an error message
        _showErrorDialog();
      }
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Signup Failed'),
        content:
            const Text('An error occurred during signup. Please try again.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<UserSignupProvider>(context);

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
                    const SizedBox(height: 16),
                    Skintypebuttons(
                      onSkinTypeSelected: (skinType) {
                        setState(() {
                          selectedSkinType = skinType;
                          showErrMsg = false;
                        });
                      },
                    ),
                    if (showErrMsg)
                      Container(
                        padding: const EdgeInsets.only(top: 16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Please select a skin type to continue.',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
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
                        FocusScope.of(context).unfocus();
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
                        onPressed: () => _completeSignup(signupProvider),
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
