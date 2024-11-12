import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/user_registration.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/anouncement_view_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class ProfileStorage {
  //Singleton pattern to avoid multiple instances
  static final ProfileStorage _instance = ProfileStorage._internal();
  factory ProfileStorage() {
    return _instance;
  }
  ProfileStorage._internal();

  Logger logger = Logger(); //for debug messages

  //profile view model, lazy initializer
  ProfileViewModel? _viewModel;
  ProfileViewModel get viewModel => _viewModel ??= ProfileViewModel();
  final getAnnouncement = AnnouncementViewModel();

  final GlobalDialogUtil _globalUtil = GlobalDialogUtil(); //utilities like loading and removing dialogs

  //userData
  final userData = GetUserData();
  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  //Firestore instance for update
  final firestoreService = FireStoreAddService();
  
  //Firebase Storage
  final storageRef = FirebaseStorage.instance.ref();

  
  Future uploadProfile(BuildContext context, String oldMuni,File image, String id, String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber, String type) async {
  
    String imagePath = "user/profile/${id}_profile.jpg"; //generate unqique reference

    final profileRef = storageRef.child(imagePath); //create reference in the storage
    try {
      //uplaod the file
      await profileRef.putFile(image);

    }
    on FirebaseException catch (e) {
      logger.e("Firebase Error: ${e.toString()}");
    }

    String url = await profileRef.getDownloadURL();
    logger.d("After URL: $url");

    logger.i("ID: $id");
    if (context.mounted) {
      addUser(context , oldMuni, url, id, name, birthdate, gender, barangay, municipality, email, mobileNumber, type);
    }
    
    
  }


  //Update user
  Future addUser(BuildContext context, String oldMuni, String url, String uid, String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber, String type) async {

    try {
      final user = UserModel(
        uid: uid,
      
        profilePicUrl: url,
        name: name, 
        birthdate: birthdate, 
        gender: gender, 
        barangay: barangay, 
        municipality: municipality, 
        email: email, 
        mobileNumber: mobileNumber,
        type: type,
        posts: userData.posts
      );
      //updates user details to Firestore Database
      await _db.collection("users").doc(curUser!.uid).update(user.toJson())
        .whenComplete( ()=> "Good")
        
        // ignore: body_might_complete_normally_catch_error
        .catchError((error){ 
            logger.e("Error Occured : ${error.toString()}");
          }
        );
      logger.i("Done Updating");
      userData.getUser();
      getAnnouncement.dbAnnouncement.listenToAnnouncements(user.municipality!);

      //remove loading
      if (context.mounted) {
        _globalUtil.removeDialog(context);
      }

      //goes back to profile
      if (context.mounted) {
        Navigator.pop(context);
      }
  
      
      if (userData.posts!.isEmpty) {
        updateProfileForum(municipality, url);
      }
      else {
        updateProfileForum(municipality, url);
      }
    } catch (e) {
      if (context.mounted) {
        _globalUtil.errorDialog(context, "Something went wrong, check you internet first");
      }
    }
    

    
    
  }

  Future updateProfileForum(String municipality, String url) async {
    for (String postIDS in userData.posts!) {
      //posts to forum to Firestore Database
      await _db.collection("forum").doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_forum").doc(postIDS).update({"Profile" : url})
        .whenComplete( ()=> "Good")
        
        // ignore: body_might_complete_normally_catch_error
        .catchError((error){ 
            logger.e("Error Occured : ${error.toString()}");
          }
        );
    }
    
  }
  
}