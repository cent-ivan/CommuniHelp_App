import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class PostReportService {
   var logger = Logger();//showing debug messages

  //userData
  //final userData = GetUserData();
  

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  Future uploadReport(String municipality, String location, String userName, String title, String content, String imageURL, String date) async {
    //upload with name first
    await _db.collection("reports").doc(municipality.toUpperCase()).set({"Municipality" : municipality})
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );

    //upload report to Firestore Database
    await _db.collection("reports").doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_reports").doc().set({
      "Sender" : userName,
      "Image" : imageURL,
      "Date" : date,
      "Title" : title,
      "Location" : location,
      "Content" : content
    })
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );
    logger.i("Done Updating");
  }

  //delete reports from Firestore
  Future deleteAnnouncement(String announcementId, String municipality) async {
    try {
      await _db.collection("reports").doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_reports").doc(announcementId).delete();
      logger.i('Document deleted successfully');
    } catch (e) {
      logger.i('Error deleting document: $e');
    }
  }
}