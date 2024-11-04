import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/user_registration.dart';
import 'package:communihelp_app/Model/forum_model.dart';
import 'package:communihelp_app/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class GetForum {
  Logger logger = Logger();

  //userData
  final userData = GetUserData();
  //show current user
  User? user = FirebaseAuth.instance.currentUser;

  //Firestore instance for update
  final firestoreService = FireStoreAddService();

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  Stream getCollection(String municipality) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> forumStream = _db.collection('forum').doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_forum").snapshots();
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
    //format time
    DateTime utcNow = DateTime.now().toUtc();
                    
    // Converting UTC to Philippine time 
    DateTime philippineTime = utcNow.add(Duration(hours: 8));
                    
    DateFormat formatter = DateFormat('dd-MM-yyyy-hh:mm-a', 'en_PH');              
    String formattedDateTime = formatter.format(philippineTime);
    
    //generate id
    List userPosts = userData.posts!;
    
    int postNum = userPosts.length;
    String postID = "POST_${userData.name}_${formattedDateTime}_$postNum";
    userPosts.add(postID);
    logger.i("Show posts: $userPosts");
    //posts to forum to Firestore Database
    await _db.collection("forum").doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()}_forum").doc(postID).set(post.toJson())
      .whenComplete( ()=> "Good")
      
      // ignore: body_might_complete_normally_catch_error
      .catchError((error){ 
          logger.e("Error Occured : ${error.toString()}");
        }
      );

    firestoreService.updateUserDetails(UserModel(
      profilePicUrl: userData.userProfURL, 
      name: userData.name, 
      birthdate: userData.birthdate,
      gender: userData.gender, 
      barangay: userData.barangay, 
      municipality: municipality, 
      email: userData.email, 
      mobileNumber: userData.mobileNumber, 
      type: userData.type, 
      posts: userPosts
    )
  );

  }

}