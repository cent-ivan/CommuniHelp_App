import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_forum.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CommunityViewModel extends ChangeNotifier{
  Logger logger = Logger(); //for debug messages

  final getForum = GetForum();

  bool? isPressed;//for like
  int userIndex = 0;


  //Firestore methods------------------------------------
  Stream getStream(String municipality) {
    return getForum.getCollection(municipality);
  }

  //check the user list if pressed or not
  void loadStatus(GetUserData user, List<Map<String,bool>> presses) {
    List<Map<String,bool>> collection = presses;
    for (int i = 0; i < collection.length; i++) {
      if (collection[i].containsKey(user.name)) {
        isPressed = collection[i][user.name]!;
      }
      else {
        isPressed = false;
      }
    }
  }

  //checks for the user and 
  void checkUser(String id, GetUserData user, int like, List<Map<String,bool>> presses) {
    logger.i("before index: $userIndex");
    List<Map<String,bool>> collection = presses;
    bool isPresent = false; //checks if user did liked
    for (int i = 0; i < collection.length; i++) {
      if (collection[i].containsKey(user.name)) { //register like if present user
        logger.i("True!!!");
        userIndex = i;
        isPresent = true;
        updateLike(id, user, like, collection);
      }
    }

    if (!isPresent) {
      logger.i("False!!!");
      //if not present 
      collection.add({user.name : false});
      isPressed = false;
      userIndex = collection.length - 1;
      updateLike(id, user, like, collection);
    }

  }

  //sends to database
  void updateLike(String id, GetUserData user, int like, List<Map<String,bool>> collection) {
    logger.i("is pressed status: $isPressed, userIndex: $userIndex");
    logger.i(">>> $userIndex, ${collection[userIndex]} - ${collection[userIndex][user.name]}");
    //adds like when not pressed the like
    if (collection[userIndex][user.name] == false) {
      isPressed = !collection[userIndex][user.name]!;
      notifyListeners();
      logger.i("after pressed status (if false): $isPressed");
      collection[userIndex] = {user.name : isPressed!};
      getForum.updateLike(id, user.municipality, like + 1, collection);
    }
    else {
      isPressed = !collection[userIndex][user.name]!;
      notifyListeners();
      logger.i("after pressed status (if true): $isPressed");
      collection[userIndex] = {user.name : isPressed!};
      getForum.updateLike(id, user.municipality, like - 1, collection);
    }
    
  }
}