import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class GetUserData extends ChangeNotifier {
  //show current user
  User? user = FirebaseAuth.instance.currentUser!;


  //Firestore instance
  final _db = FirebaseFirestore.instance;

  GetUserData() {
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      user = newUser;
      if (newUser == null) {
        reloadData(); // Clear user data on sign out
      } else {
        getUser(); // Fetch new user data on sign in
      }
    });
  }

  String name = ""; 
  String birthdate = "";
  String gender = ""; 
  String barangay = ""; 
  String municipality = ""; 
  String email = "";
  String mobileNumber = "";

  
  Future getUser() async{
    if (user == null) return;

    String id = user!.uid;
    try {
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
      print("Error: ${error.toString()}");
    }
    print("Added: $name");
  }

  void reloadData() {
    print("Reloaded...");

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