import 'package:cloud_firestore/cloud_firestore.dart';
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

  // String name = ""; 
  // String birthdate = "";
  // String gender = ""; 
  // String barangay = ""; 
  // String municipality = ""; 
  // String email = "";
  // String mobileNumber = "";

  // void loadProfile(String uname, String bday, String ugender, String ubarangay, String umunicipality, String uemail, String umobileNumber) {
  //   name = uname;
  //   birthdate = bday;
  //   gender = ugender;
  //   barangay = ubarangay;
  //   municipality = umunicipality;
  //   email = uemail;
  //   mobileNumber = umobileNumber;

  //   notifyListeners();  // Notify listeners after updating the variables
  //   print("Loaded profile: Name: $uname");
  // }

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
    DocumentSnapshot docBarangay = await _db.collection("municipalities").doc(municipalId).collection("Barangays").doc(barangayId).get();
    if (docBarangay .exists) {
      barangayValue = docBarangay ["name"];
      
    }
    notifyListeners();
  }
}