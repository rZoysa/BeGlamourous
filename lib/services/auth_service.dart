import 'package:be_glamourous/models/user_signup_data.dart';
import 'package:flutter/material.dart';
// Add your backend API service or Firebase service here
// import 'package:your_project/services/api_service.dart';

Future<void> signupUser(UserSignupData userSignupData) async {
  try {
    // Example for sending data to a backend server
    // final response = await ApiService.signupUser(userSignupData);
    // if (response.isSuccess) {
    //   // Handle successful signup
    // } else {
    //   // Handle signup failure
    // }

    // Example for Firebase Authentication
    // final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //   email: userSignupData.email,
    //   password: userSignupData.password,
    // );
    // if (userCredential.user != null) {
    //   // Save additional user data to Firestore
    //   await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
    //     'firstName': userSignupData.firstName,
    //     'lastName': userSignupData.lastName,
    //     'gender': userSignupData.gender,
    //     'age': userSignupData.age,
    //     'skinType': userSignupData.skinType,
    //   });
    // }

    // For demonstration, print the user data
    print('Signup data: ${userSignupData.email}, ${userSignupData.password}, ${userSignupData.firstName}, ${userSignupData.lastName}, ${userSignupData.gender}, ${userSignupData.age}, ${userSignupData.skinType}');
  } catch (e) {
    print('Signup failed: $e');
  }
}
