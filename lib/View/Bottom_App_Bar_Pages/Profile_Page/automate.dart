import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class Automate {
  List<String> cities = [
    "Altavas", 
    "Balete", 
    "Batan", 
    "Banga", 
    "Buruanga", 
    "Ibajay", 
    "Kalibo", 
    "Lezo", 
    "Libacao", 
    "Madalag", 
    "Malay", 
    "Makato", 
    "Malinao", 
    "Nabas", 
    "New Washington", 
    "Numancia", 
    "Tangalan"
  ];

  Map<String, String> hospitalImages = {
  "Altavas" :"ALTAVAS_DISTRICT_HOSPITAL_.jpg",
  "Buruanga" :"BURUANGA_MUNICIPAL_HOSPITAL.png",
  "Malay" :"MALAY_HOSPITAL.jpg",
  "MALAY" : "CIRIACO_S._TIROL_HOSPITAL_(BORACAY).jpg",
  "Ibajay" : "IBAJAY_DISTRICT_HOSPITAL.jpg",
  "Makato" : "MAKATO_HOSPITAL.png",
  "Madalag" : "MADALAG_MUNICIPAL_HOSPITAL.jpg",
  "Libacao":  "LIBACAO_MUNICIPAL_HOSPITAL.png"
  };

  Logger logger = Logger(); //for debug messages
  
  //Firebase Storage
  final storageRef = FirebaseStorage.instance.ref();

  //Firestore instance
  final _db = FirebaseFirestore.instance;

  Future<Uint8List> loadAsset(String assetPath) async {
    return await rootBundle.load(assetPath).then((ByteData byteData) {
      return byteData.buffer.asUint8List();
    });
  }

  List allHost = [
    "MISSION_HOSPITAL.jpg",
    "MMG.png",
    "PANAY_HEALTH_CARE.png",
    "ST._GABRIEL_HOSPITAL.jpg",
    "ST._JUDE_HOSPITAL.jpg",
    "DR._RAFAEL_S._TUMBOKON_MEMORIAL_HOSPITAL.jpg"
  ];

  Future addURL(String url, String municipality, String hostpi) async {
      //updates user details to Firestore Database
      List splitString = hostpi.split('');
          
      int len = splitString.length;
      splitString[len - 4] = "";
      splitString[len - 3] = "";
      splitString[len - 2] = "";
      splitString[len - 1] = "";
    
      String name = splitString.join("");
      Future.delayed(Duration(milliseconds: 500));
      await _db.collection("hotlines").doc(municipality.toUpperCase()).collection(name).doc("Url").set({"urlPic" : [url]})
        .whenComplete( ()=> "Good")
        
        // ignore: body_might_complete_normally_catch_error
        .catchError((error){ 
            logger.e("Error Occured : ${error.toString()}");
          }
        );
      
      logger.i("Added in $municipality");
    }

    

  Future uploadImages() async {
    

    // for (String muni in cities) {
    //   for (String hostKey in hospitalImages.keys) {
    //     // Load the asset as byte data
    //     //Uint8List imageData = await loadAsset("assets/images/hostpi/$hostpi");

    //     try {
    //       String imagePath = "hotlines/${hostKey.toUpperCase()}/hostpitals/${hospitalImages[hostKey]}"; //friestorage

    //       final imageRef = storageRef.child(imagePath); //create reference in the storage

    //       String url = await imageRef.getDownloadURL();
    //       addURL(url, hostKey, hospitalImages[hostKey]!);
    //       //await imageRef.putData(imageData);
          
    //     }
    //     on FirebaseException catch (e) {
    //       logger.e("Firebase Error: ${e.toString()}");
    //     }
    //     catch (e) {
    //       logger.e("Error: ${e.toString()}");
    //     }
    //   }
    // }
    
  }
}