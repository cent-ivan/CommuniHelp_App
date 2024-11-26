import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Model/directions_model.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class EvacuationFinderViewModel extends ChangeNotifier{
  Logger logger = Logger();
  final _dialog = GlobalDialogUtil(); //dialgs 


  Marker? origin;
  Marker? destination;

  File? image; //edited image
  File? choosenImage;

  String? imageurl;
  String? initialValue;
  String? targetEvac;
  String mode = "walking";

  
  DirectionsModel? direct;

  bool pinMode = false; //for responders to pin
  Marker? placedPin;
  LatLng? evacPos;

  //Firebase Storage
  final storageRef = FirebaseStorage.instance.ref();

  void assignEvacPos(LatLng pos) {
    evacPos = pos;
    notifyListeners();
  }

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
    initialValue = null;
    targetEvac = null;

    notifyListeners();
  }

  //send data to firestore location pf evac
  Future addEvacFirebase(String municipality, String name, LatLng pos) async {
    List splitted = capitalizeEachWord(name).split(" ");
    String keyString = splitted.join("_");

    //Upload to firebase storage
    String imagePath = "evacuation_images/${municipality.toUpperCase()}/$keyString"; //generate unqique reference
    String url;

    final profileRef = storageRef.child(imagePath); //create reference in the storage
    if (choosenImage == null) {
        url = "";
    }
    else {
      try {
        //uplaod the file
        await profileRef.putFile(choosenImage!);

      }
      on FirebaseException catch (e) {
        logger.e("Firebase Error: ${e.toString()}");
      }

      url = await profileRef.getDownloadURL();
      logger.d("After URL: $url");

      
    }
    //uppload evacuation details to Firestore Database
    try {
      await FirebaseFirestore.instance.collection('locations_evac').doc(municipality.toUpperCase()).update(
        {
          keyString : {
            "name" : capitalizeEachWord(name),
            "lat" : pos.latitude,
            "lng": pos.longitude,
            "image" : url
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

      //Deletes from the storage
      String imagePath = "evacuation_images/${municipality.toUpperCase()}/$key"; //generate unqique reference
      // Create a reference to the file to delete
      final desertRef = storageRef.child(imagePath);

      // Delete the file
      await desertRef.delete();

      logger.i('Document deleted successfully');
    } catch (e) {
      logger.i('Error deleting document: $e');
    }
  }
  
  //------------------------------------------------------------------------------------------------------------------------  
  
  //Image profile picker GALLERY
  pickImage(imageSource, BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? file  = await picker.pickImage(source: imageSource);
      image = File(file!.path);
      notifyListeners();
    }
    catch (e) {
      if (context.mounted) {
        _dialog.errorDialog(context, "No image picked");
      }
      
    }
    
  }

  //Crop Picture
  cropImage(File? image, BuildContext context) async {
    try {
      final ImageCropper cropper = ImageCropper();
      CroppedFile? croppedFile  = await cropper.cropImage(
        sourcePath: image!.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Color(0xFF57BEE6),
            toolbarTitle: "Crop Image",
            toolbarWidgetColor: Theme.of(context).colorScheme.surface,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
          )
        ]
      );
      File? croppedImage = File(croppedFile!.path);
      return croppedImage;
  
    }
    catch (e) {
      if (context.mounted) {
        _dialog.errorDialog(context, "No image picked");
      }
      
    }
  }

  void changePicked(File? newImage) {
    choosenImage = newImage;
    notifyListeners();
  }

  void newImage(File? newImage) {
    image = newImage;
    notifyListeners();
  }

  //capitalize each word for firestore keys
  String capitalizeEachWord(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
 
}