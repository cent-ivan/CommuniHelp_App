import 'package:cloud_firestore/cloud_firestore.dart';

class GetLocations {
   //Firestore instance
  final _db = FirebaseFirestore.instance;


  Stream getCollection() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> forumStream = _db.collection('evac_locations').snapshots();
    return forumStream;
  }
}