import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class GetUserData extends ChangeNotifier {
  var logger = Logger();//showing debug messages


  //show current user
  User? user = FirebaseAuth.instance.currentUser!;

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  String name = ""; 
  String birthdate = "";
  String gender = ""; 
  String barangay = ""; 
  String municipality = ""; 
  String email = "";
  String mobileNumber = "";


  GetUserData() {
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      user = newUser;
      if (newUser == null) {
        reloadData(); // Clear user data on sign out
      } else {
        getUser();
        
      }
    });
  }

  

  
  Future getUser() async{
    if (user == null) return;

    String id = user!.uid;
    try {
      await Future.delayed(Duration(seconds: 2));
      DocumentSnapshot doc = await _db.collection("users").doc(id).get();
      if (doc.exists) {
        UserModel userDetails = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        name = userDetails.name!;
        birthdate = userDetails.birthdate!;
        gender = userDetails.gender!;
        barangay = userDetails.barangay!;
        municipality = userDetails.municipality!;
        email = userDetails.email!;
        mobileNumber = userDetails.mobileNumber!;
        notifyListeners();

      }
    } catch (error) {
      logger.e("Error: ${error.toString()}");
    }
    logger.d("Added: $name");
  }

  void reloadData() {
    name = "";
    birthdate = "";
    gender = "";
    barangay = "";
    municipality = "";
    email = "";
    mobileNumber = "";
    notifyListeners();
  }
 
       
}