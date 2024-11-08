import 'package:cloud_firestore/cloud_firestore.dart';

class GetLocations {
   //Firestore instance
  final _db = FirebaseFirestore.instance;


  //firestore format
  final Map local = {
    "NABAS" : [ 
        {
        "Name" : "Nabas Multi-Purpose",
        "Location": "11.905883, 121.999098"
        }
      ]
  };

  Stream getCollection() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> forumStream = _db.collection('evac_locations').snapshots();
    return forumStream;
  }
}