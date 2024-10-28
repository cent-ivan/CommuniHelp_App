import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Model/forum_model.dart';
import 'package:logger/logger.dart';

class GetForum {
  Logger logger = Logger();

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  Stream getCollection(String municipality) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> forumStream = FirebaseFirestore.instance.collection('forum').doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_forum").snapshots();
    return forumStream;
  }

  Future updateLike(String id, String municipality, int like, List<Map<String,bool>> presses) async {
    //updates likes to Firestore Database
    await _db.collection("forum").doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_forum").doc(id).update({"Likes": like, "Presses": presses})
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );
  }

  Future postForum(String municipality, ForumModel post) async {
    //posts to forum to Firestore Database
    await _db.collection("forum").doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_forum").doc().set(post.toJson())
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );
  }
}