//import 'package:communihelp_app/FirebaseServices/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistrationViewModel extends ChangeNotifier{
  //text field controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bdayController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? municipalityValue;
  String? barangayValue;

  String? municipalId;
  String? barangayId;

  bool isActive = false;
  

  //checks if the snapshot is a collection
  bool checkCollection(DocumentSnapshot snapshot) {
    Object data  = snapshot.data()!;
    print(data);
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
      cancelText: "Cancel",
    );

    if (picked != null) {
      //converts DateTime to String then splits the string by spaces then gets the date then splits the date by - 
      String month = picked.toString().split(" ")[0].split("-")[1];
      String day = picked.toString().split(" ")[0].split("-")[2];
      String year = picked.toString().split(" ")[0].split("-")[0];

       bdayController.text = "$month/$day/$year";
    }
  }

  

  //Dropdown Firestore methods-------------------------------------------------------------------
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future updateMunicipal(String? newValue) async {
    
    municipalId = newValue;
    //Gets municipal
    DocumentSnapshot docMunicipal = await _db.collection("municipalities").doc(municipalId).get();
    if (docMunicipal.exists) {
      municipalityValue = docMunicipal["name"];
      isActive = true;
    }

    notifyListeners();
  }

  Future updateBarangay(String? newValue) async {
    barangayId = newValue;
    //Gets barangay
    DocumentSnapshot docBarangay = await _db.collection("municipalities").doc(municipalId).collection("Barangays").doc(barangayId).get();
    if (docBarangay.exists) {
      barangayValue = docBarangay ["name"];
    }

    notifyListeners();
  }
}