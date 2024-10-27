import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Model/announcement_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class GetAnnouncement extends ChangeNotifier{
  var logger = Logger();//showing debug messages

  List<AnnouncementModel> announcements = []; //list of announcements


  void listenToAnnouncements(String municipality) {
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
              date: data["Date"].toDate(),
              municipality: data["Municipality"],
              title: data["Title"],
              content: data["Content"],
            ),
          );
          notifyListeners();
        }
      }

    sortUrgent();
    // Here you can call any method you want after new data is added
    onNewDataAdded(); // Define this method to handle any additional logic you need
    }, onError: (error) {
      logger.e("Error: ${error.toString()}");
    });
}

// Method to handle actions when new data is added
void onNewDataAdded() {
  // Add your custom logic here (e.g., updating UI, notifying user, etc.)
  logger.i("New announcements have been added.");
}

void sortUrgent() {
    logger.i("Called Sort Urgent");
    //sorts 
    announcements.sort((a, b) => b.date!.compareTo(a.date!));
    announcements.sort((a, b) => b.isUrgent! ? 1 : -1);
  }

  
}