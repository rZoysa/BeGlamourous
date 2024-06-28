import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldLabelStyle = TextStyle(
      fontSize: 28,
      color: Theme.of(context).colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(80, 80, 80, 1),
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: DecorationHelper.backgroundDecoration(),
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: textFieldLabelStyle,
                      ),
                      const TextField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Color.fromRGBO(217, 217, 217, 0.32),
                          border: border,
                          enabledBorder: border,
                          focusedBorder: border,
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Password',
                        style: textFieldLabelStyle,
                      ),
                      const TextField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Color.fromRGBO(217, 217, 217, 0.32),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
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
                            'Login',
                            style: DecorationHelper.buttonTextStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
