import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier{
  //text field controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  String? municipalityValue;
  String? barangayValue;

  String? municipalId;
  String? barangayId;

  bool isActive  = false;

  //pseudo data
  String name = "John Doe";
  String birthdate = "June 03, 2002";
  String gender = "Male"; 
  String barangay = "Unidos"; 
  String municipality = "Nabas"; 
  String email = "johnd@gmail.com";
  String mobileNumber = "09123990034";

  late UserModel profile = loadProfile(name, birthdate, gender, barangay, municipality,email,  mobileNumber);

  UserModel loadProfile(String name, String birthdate, String gender, String? barangay, String? municipality, String email, String mobileNumber){
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


  //DatePicker Widget
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), 
      lastDate:  DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
      confirmText: "Confirm",
      cancelText: "Cancel",
    );

    if (picked != null) {
      //converts DateTime to String then splits the string by spaces then gets the date then splits the date by - 
      String month = picked.toString().split(" ")[0].split("-")[1];
      String day = picked.toString().split(" ")[0].split("-")[2];
      String year = picked.toString().split(" ")[0].split("-")[0];

      birthdateController.text = "$month/$day/$year";
      notifyListeners();
    }
  }


  //Firestore methods-------------------------------------------------------------------
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future updateMunicipal(String? newValue) async {
    municipalId = newValue;
    isActive = true;
    //Gets municipal
    DocumentSnapshot docMunicipal = await _db.collection("municipalities").doc(municipalId).get();
    if (docMunicipal.exists) {
      municipalityValue = docMunicipal["name"];
      
    }
    notifyListeners();
  }

  Future updateBarangay(String? newValue) async {
    barangayId = newValue;
    //Gets barangay
    DocumentSnapshot docBarangay = await _db.collection("municipalities").doc(municipalId).collection("barangays").doc(barangayId).get();
    if (docBarangay .exists) {
      barangayValue = docBarangay ["name"];
      
    }
    notifyListeners();
  }
}