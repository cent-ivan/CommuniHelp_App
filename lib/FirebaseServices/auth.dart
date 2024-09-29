import 'package:communihelp_app/FirebaseServices/user_registration.dart';
import 'package:communihelp_app/Models/user_model.dart';
import 'package:communihelp_app/Views/View_Components/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  //Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //access firestrore service
  final FireStoreAddService _firestoreAddService  = FireStoreAddService();

  //access dialogs
  final GlobalDialogUtil _globalUtil = GlobalDialogUtil(); //utilities like loading and removing dialogs

  Future registerEmailPassword(BuildContext context, String email, String userPassword, UserModel userDetail) async{
    try {
      _globalUtil.circularProgress(context); //loading screen

      //creates a user and sends it to firebase
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: userPassword);
      User? user = credential.user;

      if (user != null) {
        userDetail.uid = user.uid;
        _firestoreAddService.addUserDetails(userDetail);
      }

      if (context.mounted){
        _globalUtil.removeDialog(context);
      }

      return user;
    }
    catch (error) {
      print("Hey");
    }
  }

}