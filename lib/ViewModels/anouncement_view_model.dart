import 'package:communihelp_app/Models/announcement_model.dart';
import 'package:flutter/material.dart';

class AnnouncementViewModel extends ChangeNotifier{
  List<AnnouncementModel> announcements = [];

  AnnouncementViewModel() {
    addAnnouncement();
  }

  //Retrieve from database, make sure that aklan is in the first announcement
  void addAnnouncement(){
    announcements.add(AnnouncementModel(level: "NABAS", title: "Typhoon Incoming", content: "Prepare for incoming typhoon, tingnan ang steps na paano mag prepare"));
    announcements.add(AnnouncementModel(level: "AKLAN", title: "Aklan in Calamity", content: "Napasailalim ag Aklan sa Province in Calamity"));
    notifyListeners();
  }

}