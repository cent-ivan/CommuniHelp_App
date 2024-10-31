import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class GetUserData extends ChangeNotifier {
  var logger = Logger();//showing debug messages


  //show current user
  User? user = FirebaseAuth.instance.currentUser;

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  String uid = "";
  String userProfURL = "";
  String name = ""; 
  String birthdate = "";
  String gender = ""; 
  String barangay = ""; 
  String municipality = ""; 
  String email = "";
  String mobileNumber = "";
  String type = "";


  GetUserData._() {
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      user = newUser;
      if (newUser == null) {
        reloadData(); // Clear user data on sign out
      } else {
        getUser();
        
      }
    });
  }

  // Static instance of the singleton
  static final GetUserData _instance = GetUserData._();

  // Public factory constructor
  factory GetUserData() {
    return _instance; // Returns the same instance every time
  }


  Future getUser() async{
    if (user == null) return;

    String id = user!.uid;
    uid = user!.uid;
    try {
      DocumentSnapshot doc = await _db.collection("users").doc(id).get();
      if (doc.exists) {
        //assign it from the model
        UserModel userDetails = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        municipality = userDetails.municipality!;
        name = userDetails.name!;
        userProfURL = userDetails.profilePicUrl!;
        birthdate = userDetails.birthdate!;
        gender = userDetails.gender!;
        barangay = userDetails.barangay!;
        email = userDetails.email!;
        mobileNumber = userDetails.mobileNumber!;
        type = userDetails.type!;
        notifyListeners();

      }
    } catch (error) {
      logger.e("Error: ${user!.uid} ${error.toString()}");
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
    type = "";
    notifyListeners();
  }
 
       
}