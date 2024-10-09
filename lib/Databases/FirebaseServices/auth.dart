import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/user_registration.dart';
import 'package:communihelp_app/Models/user_model.dart';
import 'package:communihelp_app/Views/View_Components/dialogs.dart';
import 'package:communihelp_app/Views/View_Components/login_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthService {
  //Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //access firestrore service
  final FireStoreAddService _firestoreAddService  = FireStoreAddService();

  //access dialogs
  final GlobalDialogUtil _globalUtil = GlobalDialogUtil(); //utilities like loading and removing dialogs
  final LoginDialogs _loginDialogs = LoginDialogs();

  //----Firebase authentication methods-----------------------------------------------------------------
  //User login method
  Future logInEmailPassword(BuildContext context, String email, String password) async {
    try {
      _globalUtil.circularLoggingIn(context); //loading screen

      UserCredential credential = await  _auth.signInWithEmailAndPassword(email: email, password: password);

      if (context.mounted){
        _globalUtil.removeDialog(context);
      }

      return credential.user;
    }
    on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          if (context.mounted){
            _globalUtil.removeDialog(context);
            _loginDialogs.displayMessage(context, "Invalid Email. Check your email");
          }
          break;
        case "wrong-password":
          if (context.mounted){
            _globalUtil.removeDialog(context);
            _loginDialogs.displayMessage(context, "Wrong Password. Double check your password and try again.");
          }
          break;
        case "user-not-found":
          if (context.mounted){
            _globalUtil.removeDialog(context);
            _loginDialogs.displayMessage(context, "User not found. User may not exist.");
          }
          break;
        default:
        if (context.mounted) {
          _globalUtil.removeDialog(context);
          _globalUtil.unknownErrorDialog(context, error.message.toString());
        }
      }
    }
    catch (error) {
      if (context.mounted){
        _globalUtil.removeDialog(context);
        _globalUtil.unknownErrorDialog(context, error.toString());
      }
    }
  }

  //register user methods----
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
      if (context.mounted){
        _globalUtil.removeDialog(context);
        _globalUtil.unknownErrorDialog(context, error.toString());
      }
    }
  }

  //Log out
  Future<void> signOut(BuildContext context) async {
    _globalUtil.circularSignout(context);
    await Future.delayed(const Duration(seconds: 1,milliseconds: 5));
    if (context.mounted) {
      _globalUtil.removeDialog(context);
    }
    await FirebaseAuth.instance.signOut();
  }
}