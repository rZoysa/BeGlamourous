import 'package:be_glamourous/models/user_signup_data.dart';
import 'package:flutter/material.dart';

class UserSignupProvider with ChangeNotifier {
  final UserSignupData _userData = UserSignupData(
    email: '',
    password: '',
    firstName: '',
    lastName: '',
    gender: '',
    age: 18,
    skinType: '',
  );

  UserSignupData get userData => _userData;

  void updateEmail(String email) {
    _userData.email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    _userData.password = password;
    notifyListeners();
  }

  void updateFirstName(String firstName) {
    _userData.firstName = firstName;
    notifyListeners();
  }

  void updateLastName(String lastName) {
    _userData.lastName = lastName;
    notifyListeners();
  }

  void updateGender(String gender) {
    _userData.gender = gender;
    notifyListeners();
  }

  void updateAge(int age) {
    _userData.age = age;
    notifyListeners();
  }

  void updateSkinType(String skinType) {
    _userData.skinType = skinType;
    notifyListeners();
  }

  Future<bool> completeSignup() async {
    // Implement your signup logic here, using _userData
    print("Signing up user: ${_userData.email}");
    // Simulate signup delay
    await Future.delayed(const Duration(seconds: 2));
    return true; // Simulate a successful signup
  }
}
