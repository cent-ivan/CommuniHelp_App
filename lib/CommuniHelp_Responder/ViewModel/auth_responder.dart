import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/user_registration.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/View/View_Components/login_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthResponder {
  Logger logger = Logger();

  //Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Firestore instance
  final _db = FirebaseFirestore.instance;
  
  //access firestrore service
  final FireStoreAddService _firestoreAddService  = FireStoreAddService();

  //access dialogs
  final GlobalDialogUtil _globalUtil = GlobalDialogUtil(); //utilities like loading and removing dialogs
  final LoginDialogs _loginDialogs = LoginDialogs();

  final userData = GetUserData();


  //----Firebase authentication methods-----------------------------------------------------------------
  //User login method
  Future logInEmailPassword(BuildContext context, String email, String password) async {
    
    try {
       _globalUtil.circularLoggingIn(context); //loading screen

       //checks first if responder or no
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      List<QueryDocumentSnapshot> docs = snapshot.docs;
      for (var doc in docs) {
        if (doc.get("Email") == email) {
          DocumentSnapshot snap = await _db.collection("users").doc(doc.id).get();
          if (snap.exists) {
            Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
            if (userData["Type"] ==  "responder") {
             
              UserCredential credential = await  _auth.signInWithEmailAndPassword(email: email, password: password); //logins if responder
              if (context.mounted){
                _globalUtil.removeDialog(context);
              }

              return credential.user;
            }
          }
          else {
          if (context.mounted){
              _globalUtil.removeDialog(context);
              _loginDialogs.displayMessage(context, "Invalid User. This user is not a RESPONDER!"); //shows if not a responer type
            }
          }

        } 
      }
      
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
            _loginDialogs.displayMessage(context, "User not found. User may not exist. Register to have an account!");
          }
          break;
        case "network-request-failed":
          if (context.mounted){
            _globalUtil.removeDialog(context);
            _loginDialogs.displayMessage(context, "No connection. Connect to a stable connection");
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
        _globalUtil.unknownErrorDialog(context, error.toString(), );
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
    await Future.delayed(const Duration(seconds: 1,milliseconds: 500));
    if (context.mounted) {
      _globalUtil.removeDialog(context);
    }
    await FirebaseAuth.instance.signOut();
  }
}