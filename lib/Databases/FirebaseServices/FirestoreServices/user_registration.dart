import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/View/View_Components/login_dialogs.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/anouncement_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class FireStoreAddService {
  var logger = Logger();//showing debug messages
  final GlobalDialogUtil _globalUtil = GlobalDialogUtil(); //utilities like loading and removing dialogs
  final LoginDialogs _loginDialogs = LoginDialogs();

  //userData
  final userData = GetUserData();
  final getAnnouncement = AnnouncementViewModel();

  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;
  
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
    try {
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
      } catch (e) {
        logger.e("Done Updating");
      }
    
  }


  //Update email in authentication
  Future updateAuthEmail(String uid ,String email, String password, String newEmail, BuildContext context) async {
    try {
      // Get the current user
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Re-authenticate the user
        final credential = EmailAuthProvider.credential(email: email, password: password);
        
        await currentUser.reauthenticateWithCredential(credential);

        // Update the email address
        await currentUser.verifyBeforeUpdateEmail(newEmail);

        if (currentUser.emailVerified) {
          //calls adding to firestore
          updateUserEmail(uid, newEmail);
          if (context.mounted) {
            _globalUtil.showWaiting(context);
          }
        }
        else {
          //if not yet verified show this
          if (context.mounted) {
            _globalUtil.showWaiting(context);
          }
        }

        
        
        logger.i('Email changed successfully');
      }
    } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-email":
            if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayError(context, "Invalid Email. Check your email");
            }
            break;
          case "wrong-password":
            if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayError(context, "Wrong Password. Double check your password and try again.");
            }
            break;
          case "user-not-found":
            if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayError(context, "User not found. User may not exist. Register to have an account!");
            }
            break;
          case "network-request-failed":
            if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayError(context, "No connection. Connect to a stable connection");
            }
            break;
          default:
          if (context.mounted) {
            _globalUtil.removeDialog(context);
            _globalUtil.unknownErrorDialog(context, e.message.toString());
          }
      }
    }
    catch (e) {
      if (context.mounted){
        _globalUtil.removeDialog(context);
        _globalUtil.unknownErrorDialog(context, e.toString(), );
      }
    }
  }


  //update email in the firestore
  Future updateUserEmail(String id, String newEmail) async {
    //updates user details to Firestore Database
    await _db.collection("users").doc(id).update({"Email" : newEmail})
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );
    logger.i("Done Updating");
    userData.getUser();
  }


  //Update password in authentication
  Future updateAuthPass(String uid ,String email, String password, String newPass, BuildContext context) async {
    try {
      // Get the current user
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Re-authenticate the user
        final credential = EmailAuthProvider.credential(email: email, password: password);
        
        await currentUser.reauthenticateWithCredential(credential);

        // Update the email address
        await currentUser.updatePassword(newPass);
        if (context.mounted) {
          _globalUtil.showPassChange(context);
        }
        
        logger.i('Password changed successfully');
      }
    } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-email":
            if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayError(context, "Invalid Email. Check your email");
            }
            break;
          case "wrong-password":
            if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayError(context, "Wrong Password. Double check your password and try again.");
            }
            break;
          case "user-not-found":
            if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayError(context, "User not found. User may not exist. Register to have an account!");
            }
            break;
          case "network-request-failed":
            if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayError(context, "No connection. Connect to a stable connection");
            }
            break;
          default:
          if (context.mounted) {
            _globalUtil.removeDialog(context);
            _globalUtil.unknownErrorDialog(context, e.message.toString());
          }
      }
    }
    catch (e) {
      if (context.mounted){
        _globalUtil.removeDialog(context);
        _globalUtil.unknownErrorDialog(context, e.toString(), );
      }
    }
  }
}