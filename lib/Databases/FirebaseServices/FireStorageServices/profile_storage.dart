import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/user_registration.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  //userData
  final userData = GetUserData();

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  //Firestore instance for update
  final firestoreService = FireStoreAddService();
  
  //Firebase Storage
  final storageRef = FirebaseStorage.instance.ref();

  
  Future uploadProfile(String oldMuni,File image, String id, String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber, String type) async {
  
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
    addUser(oldMuni, url, id, name, birthdate, gender, barangay, municipality, email, mobileNumber, type);
    
  }



  Future addUser(String oldMuni, String url, String uid, String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber, String type) async {
    firestoreService.updateUserDetails(UserModel(
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
      )
    );

    if (userData.posts!.isEmpty) {
      updateProfileForum(municipality, url);
    }
    else {
      updateProfileForum(municipality, url);
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