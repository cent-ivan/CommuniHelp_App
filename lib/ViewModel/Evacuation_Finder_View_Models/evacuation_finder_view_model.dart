import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Model/directions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class EvacuationFinderViewModel extends ChangeNotifier{
  Logger logger = Logger();


  Marker? origin;
  Marker? destination;
  
  DirectionsModel? direct;

  bool pinMode = false; //for responders to pin
  Marker? placedPin;

  BitmapDescriptor userMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor evacIcon = BitmapDescriptor.defaultMarker;

  static final  customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );


  void setCustomMarker() {
    logger.i("Sets icon");
    //creates custom marker
    BitmapDescriptor.asset(ImageConfiguration.empty, 'assets/images/shelter.png', height: 25, width: 25).then((icon) { 
      evacIcon = icon;
    });
  }

  


  //get users symbol
  void userCustomMarker(GetUserData userData) {

    BitmapDescriptor.asset(ImageConfiguration.empty, 'assets/images/user_spot.png', height: 28, width: 28).then((icon) { 
      userMarker = icon;
    });
  }
  

  void clearMyPins() {
    origin = null;
    destination =  null;
    direct = null;
    notifyListeners();
  }

  //send data to firestore location pf evac
  Future addEvacFirebase(String municipality, String name, LatLng pos) async {
    List splitted = capitalizeEachWord(name).split(" ");
    String keyString = splitted.join("_");
    //uppload evacuation details to Firestore Database
    try {
      await FirebaseFirestore.instance.collection('locations_evac').doc(municipality.toUpperCase()).update(
        {
          keyString : {
            "name" : capitalizeEachWord(name),
            "lat" : pos.latitude,
            "lng": pos.longitude
          }
        }
      );
      placedPin = null;
      notifyListeners();
    } catch (e) {
      logger.e("Error: ${e.toString()}");
    }
    
     
    logger.i("Done Uploading");
  }

  //delete location from Firestore
  Future deleteEvacPin(String key, String municipality) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('locations_evac').doc(municipality.toUpperCase());
      final deletes = <String, dynamic>{
        key: FieldValue.delete(),
      };
      docRef.update(deletes);
      logger.i('Document deleted successfully');
    } catch (e) {
      logger.i('Error deleting document: $e');
    }
  }

  //capitalize each word for firestore keys
  String capitalizeEachWord(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
 
}