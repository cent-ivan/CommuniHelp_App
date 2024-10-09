import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../../Models/user_model.dart';
List<String> options =["Male", "Female"]; //for radio list

class ProfileViewModel extends ChangeNotifier{
  
  String currentOption = options[0];

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


  //inserts user data to textcontrollers
  void loadData(BuildContext context) {
    final getService = Provider.of<GetUserData>(context,listen: false);
    for (var option in options) {
      if (option == getService.gender){
        currentOption = option;
      }
    }
    
    nameController.text = getService.name;
    birthdateController.text = getService.birthdate;
    emailController.text = getService.email;
    contactController.text = getService.mobileNumber;
    print("running..");

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
  //TODO: check if its online
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