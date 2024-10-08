import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Models/user_model.dart';

class FireStoreAddService {
  //Firestore instance
  final _db = FirebaseFirestore.instance;

  Future addUserDetails(UserModel user) async {
    //adds user details to Firestore Database
    await _db.collection("users").doc(user.uid).set(user.toJson())
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          print("Error Occured : ${error.toString()}");
        }
      );
  }

  Future updateUserDetails(UserModel user) async {
    //updates user details to Firestore Database
    await _db.collection("users").doc(user.uid).set(user.toJson())
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          print("Error Occured : ${error.toString()}");
        }
      );
  }


  //Update email in authentication
  Future editFirestoreEmail(UserModel user, String newEmail) async {
    await _db.collection("users").doc(user.uid).update({"Email": newEmail})
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          print("Error Occured : ${error.toString()}");
        }
      );
  }
}