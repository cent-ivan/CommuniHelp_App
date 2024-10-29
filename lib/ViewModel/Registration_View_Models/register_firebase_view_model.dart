import 'package:communihelp_app/Databases/FirebaseServices/auth.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:flutter/material.dart';

class RegisterFirebaseViewModel{
  final AuthService _auth =  AuthService();

  //adding user
  Future addUser(BuildContext context, String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber, String password, String confirmPassword, String type) async {
    //creates a Model for the details of the user
    final UserModel userDetails = createUserDetails(name, birthdate, gender, barangay, municipality, email, mobileNumber, type);
    if (password == confirmPassword) {
      await _auth. registerEmailPassword(context, email, password, userDetails);
    }
  }


  UserModel createUserDetails(String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber, String type) {
    return UserModel(
      uid: "",
      name: name, 
      birthdate: birthdate, 
      gender: gender, 
      barangay: barangay, 
      municipality: municipality, 
      email: email, 
      mobileNumber: mobileNumber,
      type: type
    );
  }
}