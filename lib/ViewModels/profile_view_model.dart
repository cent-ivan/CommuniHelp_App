import 'package:communihelp_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier{
  String name = "John Doe";
  String birthdate = "June 03, 2002";
  String gender = "Male"; 
  String barangay = "Unidos"; 
  String municipality = "Nabas"; 
  String email = "johnd@gmail.com";
  String mobileNumber = "09123990034";

  late UserModel profile = loadProfile(name, birthdate, gender, barangay, municipality,email,  mobileNumber);

  UserModel loadProfile(String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber){
    return UserModel(
      name: name, 
      birthdate: birthdate, 
      gender: gender, 
      barangay: barangay, 
      municipality: municipality, 
      email: email,
      mobileNumber: mobileNumber
    );
  }

  void updateProfile(String updateName, String updateBirthdate, String updateGender, String updateBarangay, String updateMunicipality, String updateEmail, String updateMobileNumber){
    name = updateName;
    birthdate = updateBirthdate;
    gender = updateGender;
    barangay = updateBarangay;
    municipality = updateMunicipality;
    email = updateEmail;
    mobileNumber = updateMobileNumber;
    profile = loadProfile(name, birthdate, gender, barangay, municipality, email, mobileNumber);
    notifyListeners();
  }
}