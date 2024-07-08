import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;
  bool _isObscure = true;

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
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
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
                        TextFormField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Color.fromRGBO(217, 217, 217, 0.32),
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border,
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Password',
                          style: textFieldLabelStyle,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor:
                                const Color.fromRGBO(217, 217, 217, 0.32),
                            border: border,
                            focusedBorder: border,
                            enabledBorder: border,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white54,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          obscureText: _isObscure,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
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
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Process login
                                print(
                                    "${_emailController.text.toUpperCase().trim()}\n${_passwordController.text}");
                              } else {
                                setState(() {
                                  _autoValidate = true;
                                });
                              }
                            },
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
