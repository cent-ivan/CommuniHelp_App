import 'package:communihelp_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier{

  late UserModel profile = loadProfile();

  UserModel loadProfile() {
    return UserModel(
      name: "John Doe", 
      birthdate: "June 03, 2002", 
      gender: "Male", 
      barangay: "Unidos", 
      municipality: "Nabas", 
      mobileNumber: "09123990034"
    );
  }
}