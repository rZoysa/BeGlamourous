import 'dart:convert';

import 'package:be_glamourous/models/user_signup_data.dart';
import 'package:be_glamourous/services/api_url.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final String apiURL = apiUrl();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

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
      Logger().e('User registered successfully');
      return true; // Signifies success
    } else {
      Logger()
          .e('Failed to register user. Status code: ${response.statusCode}');
      Logger().e('Response body: ${response.body}');
      return false; // Signifies failure
    }
  } catch (e) {
    Logger().e('Signup failed: $e');
    return false; // Signifies failure
  }
}

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final String url = "$apiURL/api/login"; // API endpoint URL for login

  // Hash the password using SHA-256
  var bytes = utf8.encode(password); // data being hashed
  var hashedPassword = sha256.convert(bytes).toString();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': hashedPassword,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful login
      final responseData = jsonDecode(response.body);

      String token = responseData['token'];
      int userID = responseData['userID'];
      await secureStorage.write(key: 'jwt', value: token);
      await secureStorage.write(key: 'userID', value: userID.toString());

      return {'success': true, 'message': 'Login successful'};
    } else {
      // Parse response body for error message if available
      String errorMessage = 'Login failed. Please try again.';
      try {
        errorMessage = response.body;
      } catch (e) {
        Logger().e('Error parsing response body: $e');
      }

      Logger().e('Failed to log in. Status code: ${response.statusCode}');
      Logger().e('Response body: ${response.body}');
      return {
        'success': false,
        'message': errorMessage,
      };
    }
  } catch (e) {
    Logger().e('Login failed: $e');
    return {
      'success': false,
      'message': 'Network error or server unreachable. Please try again later.'
    };
  }
}
