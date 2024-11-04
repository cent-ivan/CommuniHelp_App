import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Model/announcement_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class GetAnnouncement extends ChangeNotifier{
  var logger = Logger();//showing debug messages

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  List<AnnouncementModel> announcements = []; //list of announcements


  Future listenToAnnouncements(String municipality) async{
    await Future.delayed(Duration(seconds: 3));
    CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance
        .collection("announcements")
        .doc(municipality.toUpperCase())
        .collection("${municipality.toUpperCase()}_announcement");
      

    // Use snapshots() to listen for changes in the collection
    collection.snapshots().listen((qrySnapshot) {
      if (announcements.isNotEmpty) {
        announcements.clear();
      }
      
      // Process each document in the snapshot
      for (var doc in qrySnapshot.docs) {
        // Check if the document exists
        if (doc.exists) {
          Map<String, dynamic> data = doc.data(); // Convert object into map
          // Add the announcement to the list
          announcements.add(
            AnnouncementModel(
              isUrgent: data["Urgent"],
              level: data["Level"],
              date: data["Date"],
              municipality: data["Municipality"],
              title: data["Title"],
              content: data["Content"],
            ),
          );
          notifyListeners();
        }
      }

    sortUrgent();
  
    onNewDataAdded(); //Notification
    }, onError: (error) {
      logger.e("Error: ${error.toString()}");
    });
}

  void onNewDataAdded() {
    //  updating UI, notifying user
    logger.i("New announcements have been added.");
  }



  void sortUrgent() {
    logger.i("Called Sort Urgent");
    //sorts 
    
    
    sortByDateString();
    announcements.sort((a, b) => b.isUrgent! ? 1 : -1); //sort by urgent
  }

  void sortByDateString() {
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


  //add announcement to Firestore
  Future addAnnouncement(String municipality, AnnouncementModel announcement) async {
    await _db.collection("announcements").doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_announcement").doc().set(announcement.toJson())
    .whenComplete( ()=> "Good")
      
    // ignore: body_might_complete_normally_catch_error
    .catchError((error){ 
        logger.e("Error Occured : ${error.toString()}");
      }
    );
  }


  
}