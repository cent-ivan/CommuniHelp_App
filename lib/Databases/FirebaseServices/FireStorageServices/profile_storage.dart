import 'dart:io';

import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/user_registration.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';


class ProfileStorage {
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

  //Firestore instance for update
  final firestoreService = FireStoreAddService();
  
  //Firebase Storage
  final storageRef = FirebaseStorage.instance.ref();

  
  Future uploadProfile(File image, String id, String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber, String type) async {
    //final appDocDir = await getApplicationDocumentsDirectory(); //sample dela fterwards
    //logger.i("called: $appDocDir");
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


    addUser(url, id, name, birthdate, gender, barangay, municipality, email, mobileNumber, type);
    
  }

  Future addUser(String url, String uid, String name, String birthdate, String gender, String barangay, String municipality, String email, String mobileNumber, String type) async {
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
      type: "user"
      )
    );

    userData.getUser();
  }
  
}