import 'package:be_glamourous/Screens/signup_screen/signup_page_3.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';

class SignupPage2 extends StatefulWidget {
  const SignupPage2({super.key});

  @override
  State<SignupPage2> createState() => _SignupPage2State();
}

class _SignupPage2State extends State<SignupPage2> {
  String gender = '';
  int selectedAge = 18;

  @override
  void initState() {
    super.initState();
  }

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

    final List<int> ages = List.generate(60, (index) => index + 16);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                          'First Name',
                          style: textFieldLabelStyle,
                        ),
                        const TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'First Name',
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
                          'Last Name',
                          style: textFieldLabelStyle,
                        ),
                        const TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
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
                          'Gender',
                          style: textFieldLabelStyle,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    gender = 'Male';
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                label: const Text(
                                  'Male',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                icon: const Icon(Icons.male),
                                iconAlignment: IconAlignment.end,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: gender == 'Male'
                                      ? Theme.of(context).colorScheme.secondary
                                      : const Color.fromRGBO(
                                          217, 217, 217, 0.60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  minimumSize: const Size.square(55),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  gender = 'Female';
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              label: const Text(
                                'Female',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              icon: const Icon(Icons.female),
                              iconAlignment: IconAlignment.end,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: gender == 'Female'
                                    ? Theme.of(context).colorScheme.secondary
                                    : const Color.fromRGBO(217, 217, 217, 0.60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                minimumSize: const Size.square(55),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Your Age',
                          style: textFieldLabelStyle,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              ages.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAge = ages[index];
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selectedAge == ages[index]
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 0.0,
                                      ),
                                    ),
                                    child: Text(
                                      '${ages[index]}',
                                      style: TextStyle(
                                        fontSize: 32,
                                        color: selectedAge == ages[index]
                                            ? Colors.white
                                            : Colors.white30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const SignupPage3();
                                },
                              ));
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
                              'Next',
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
        ),
      ),
    );
  }
}
