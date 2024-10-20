import 'package:flutter/material.dart';
import '../../Databases/FirebaseServices/auth.dart';

class LoginFirebaseViewModel {
  //Firebase Service obj
  final AuthService _auth =  AuthService();

  //login user
  Future loginUser(BuildContext context, String email,  String password) async {
    await _auth.logInEmailPassword(context, email, password);
  }
}