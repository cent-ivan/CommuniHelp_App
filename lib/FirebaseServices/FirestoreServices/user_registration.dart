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
}