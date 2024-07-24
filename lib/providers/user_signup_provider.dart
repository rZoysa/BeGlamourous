import 'package:be_glamourous/models/user_signup_data.dart';
import 'package:be_glamourous/services/auth_service.dart';
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
    
    // print("Signing up user: ${_userData.email}");
    
    bool result = await signupUser(_userData);
    return result; 
  }
}
