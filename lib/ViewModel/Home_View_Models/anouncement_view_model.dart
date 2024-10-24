import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_announcement.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../Databases/FirebaseServices/FirestoreServices/get_user_data.dart';

class AnnouncementViewModel extends ChangeNotifier{
  Logger logger = Logger(); //for debug messages

  AnnouncementViewModel() {
    logger.i("Announcement called");
    addAnnouncement();
  }


  GetUserData getData = GetUserData();
  GetAnnouncement dbAnnouncement = GetAnnouncement();


  //Retrieve from database, make sure that aklan is in the first announcement
  Future addAnnouncement() async{
    await getData.getUser();
    String municipalityName = getData.municipality;
    dbAnnouncement.announcements = [];
    dbAnnouncement.listenToAnnouncements(municipalityName);
    notifyListeners();
  }

  void clearList() {
    dbAnnouncement.announcements.clear();
    notifyListeners();
    logger.i("cleared");
  }
}