import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_announcement.dart';
import 'package:communihelp_app/Model/announcement_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../Databases/FirebaseServices/FirestoreServices/get_user_data.dart';

class AnnouncementViewModel extends ChangeNotifier{
  Logger logger = Logger(); //for debug messages

  GetUserData getData = GetUserData();
  GetAnnouncement dbAnnouncement = GetAnnouncement();

  List<DocumentSnapshot> previousDocs = [];

  Stream getStream(String municipality) {
    return dbAnnouncement.getAnnouncementStream(municipality);
  }


  //sorting
  void sortUrgent(List announcements) {
    logger.i("Called Sort Urgent");
    //sorts 
    
    sortByDateString(announcements);
    announcements.sort((a, b) => b["Urgent"] ? 1 : -1); //sort by urgent
  }
  void sortByDateString(List announcements) {
    final DateFormat dateFormat = DateFormat('d/M/y, h:mm a');
    
    announcements.sort((a, b) {
      try {
        final dateA = dateFormat.parse(a.date!);
        final dateB = dateFormat.parse(b.date!);

        return  dateB.compareTo(dateA);
      }
      catch (e) {
        return 1;
      }
    });
  }


  Future addAnnouncement(AnnouncementModel announcement) async {
    await getData.getUser();
    String municipality = getData.municipality;
    dbAnnouncement.addAnnouncement(municipality, announcement);
    notifyListeners();
  }


  //Retrieve from database, make sure that aklan is in the first announcement
  Future loadAnnouncement() async{
    if (dbAnnouncement.announcements.isEmpty) {
      await getData.getUser();
      String municipality = getData.municipality;
      dbAnnouncement.listenToAnnouncements(municipality);
      notifyListeners();
    }
    
  }
}