import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:logger/logger.dart';


class FireStoreAddService {
  var logger = Logger();//showing debug messages

  //userData
  final userData = GetUserData();
  

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  Future addUserDetails(UserModel user) async {
    //adds user details to Firestore Database
    await _db.collection("users").doc(user.uid).set(user.toJson())
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );

  }

  Future updateUserDetails(UserModel user) async {
    //updates user details to Firestore Database
    await _db.collection("users").doc(user.uid).set(user.toJson())
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );
    logger.i("Done Updating");
    userData.getUser();
  }


  //Update email in authentication
  Future editFirestoreEmail(UserModel user, String newEmail) async {
    await _db.collection("users").doc(user.uid).update({"Email": newEmail})
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );
  }
}