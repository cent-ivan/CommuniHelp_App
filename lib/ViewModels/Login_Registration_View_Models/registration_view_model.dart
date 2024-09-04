//import 'package:communihelp_app/FirebaseServices/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistrationViewModel extends ChangeNotifier{
  //text field controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? municipalityValue;
  String? barangayValue;

  bool isActive = false;

  //final AuthService _auth =  AuthService();

  void updateMunicipality(String? newValue) {
    municipalityValue = newValue;
    isActive = true;
    notifyListeners();
  }

  void updateBarangay(String? newValue) {
    barangayValue = newValue;
    notifyListeners();
  }

  //checks if the snapshot is a collection
  bool checkCollection(QueryDocumentSnapshot snapshot) {
    Object data  = snapshot.data()!;
    if (data is Map) {
      return true;
    }
    return false;
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
      cancelText: "No",
    );

    if (picked != null) {
      //converts DateTime to String then splits the string by spaces then gets the date then splits the date by - 
      String month = picked.toString().split(" ")[0].split("-")[1];
      String day = picked.toString().split(" ")[0].split("-")[2];
      String year = picked.toString().split(" ")[0].split("-")[0];

       ageController.text = "$month/$day/$year";
    }
  }
}