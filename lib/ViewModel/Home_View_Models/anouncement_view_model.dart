import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_announcement.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../Databases/FirebaseServices/FirestoreServices/get_user_data.dart';

class AnnouncementViewModel extends ChangeNotifier{
  Logger logger = Logger(); //for debug messages

  GetUserData getData = GetUserData();
  GetAnnouncement dbAnnouncement = GetAnnouncement();

  AnnouncementViewModel._() {
    addAnnouncement();
  }

  // Static instance of the singleton
  static final AnnouncementViewModel _instance = AnnouncementViewModel._();

  // Public factory constructor
  factory AnnouncementViewModel() {
    return _instance; // Returns the same instance every time
  }


  //Retrieve from database, make sure that aklan is in the first announcement
  Future addAnnouncement() async{
    await getData.getUser();
    String municipality = getData.municipality;
    dbAnnouncement.listenToAnnouncements(municipality);
    notifyListeners();
  }
}