import 'dart:convert';

import 'package:be_glamourous/models/user_signup_data.dart';
import 'package:be_glamourous/services/api_url.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

final String apiURL = apiUrl();

Future<bool> signupUser(UserSignupData userSignupData) async {
  final String url = "$apiURL/api/signup"; // API endpoint URL

  // Hash the password using SHA-256
  var bytes = utf8.encode(userSignupData.password); // data being hashed
  var hashedPassword = sha256.convert(bytes).toString();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': userSignupData.email,
        'password': hashedPassword,
        'firstName': userSignupData.firstName,
        'lastName': userSignupData.lastName,
        'gender': userSignupData.gender,
        'age': userSignupData.age,
        'skinType': userSignupData.skinType,
      }),
    );

    if (response.statusCode == 201) {
      print('User registered successfully');
      return true; // Signifies success
    } else {
      print('Failed to register user. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false; // Signifies failure
    }
  } catch (e) {
    print('Signup failed: $e');
    return false; // Signifies failure
  }
}
