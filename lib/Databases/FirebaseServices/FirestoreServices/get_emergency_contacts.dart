import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../../Model/Emergency_contact_model/emergency_contacts_model.dart';
import '../../HiveServices/hive_db_emergencycontact.dart';

class GetEmergencyContacts {
  //Firestore instance
  final _db = FirebaseFirestore.instance;
  
  var logger = Logger();//showing debug messages

  final getStoredCollection = EmergencyContactLocalDatabase();//local hive db

  List<EmergencyContactsModel> queryContacts = [];

  String formatTelecom(String txt) {
    if (txt.contains("HotlineCPNo.")) {
      return "Hotline Cell Phone Number";
    }
    final telecom = txt.split(RegExp(r'(?=[A-Z])'));
    final telecomName = telecom.join(" ");

    return telecomName.toUpperCase();
  }

  String formatName(String txt) {
    String result = txt.replaceAll(RegExp(r'_'), ' ');

    return result;
  }

  
  //gets number of LDDRMO
  Future getLDRRMOContacts(String municipality) async {
    CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection("hotlines").doc(municipality.toUpperCase()).collection("${municipality.toUpperCase()} LDRRMO");

    try{
      QuerySnapshot qrySnapshot = await collection.get();
      //final data =  qrySnapshot.docs.map((doc) => doc.data());
      for (var doc in qrySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>; //converts snapshot to dict
        if (data["number"].length > 1) {
          for (var number in data["number"]){
            final telecomName = formatTelecom(doc.id);
            //gets url of image
            for (var doc in qrySnapshot.docs) {
               if (doc.id.contains("Url")) {
                final dataURL = doc.data() as Map<String, dynamic>; //converts snapshot to dict
                queryContacts.add(EmergencyContactsModel(contactType: "LDRRMO", telecom: telecomName , number: number, contactName: "$municipality LDRRMO", url: dataURL["urlPic"][0]));
               }
            }
            
          }
        }
        else {
          final telecomName = formatTelecom(doc.id);
          for (var doc in qrySnapshot.docs) {
             if (doc.id.contains("Url")) {
              final dataURL = doc.data() as Map<String, dynamic>; //converts snapshot to dict
              queryContacts.add(EmergencyContactsModel(contactType: "LDRRMO", telecom: telecomName, number: data["number"][0], contactName: "$municipality LDRRMO", url: dataURL["urlPic"][0]));
             }
          }
          
        }
      }


    }
    catch (error) {
      logger.e("Error: ${error.toString()}");
    }
  }

  //gets number of AMBULANCE
  Future getHostpitalContacts(String municipality) async {
  
    try{
      DocumentSnapshot doc = await _db.collection("hotlines").doc(municipality.toUpperCase()).get();
      if (doc.exists) {
        Map data = doc.data() as Map<String, dynamic>;
        for (var hostpital in data["hostpital_list"]) {
          CollectionReference<Map<String, dynamic>> collection = _db.collection("hotlines").doc(municipality.toUpperCase()).collection(hostpital);
          QuerySnapshot qrySnapshot = await collection.get();

          //final data =  qrySnapshot.docs.map((doc) => doc.data());
          for (var doc in qrySnapshot.docs) {

            if (!doc.id.contains("Url")) {
              final data = doc.data() as Map<String, dynamic>; //converts snapshot to dict
              if (data["number"].length > 1) {
                for (var number in data["number"]){
                  final telecomName = formatTelecom(doc.id);
                  final name = formatName(hostpital);
                  //gets url of image
                  for (var doc in qrySnapshot.docs) {
                    if (doc.id.contains("Url")) {
                      final dataURL = doc.data() as Map<String, dynamic>; //converts snapshot to dict
                      queryContacts.add(EmergencyContactsModel(contactType: "AMBULANCE", telecom: telecomName, number: number, contactName: name, url: dataURL["urlPic"][0]));
                    }
                  }
                  
                }
              }
              else {
                final telecomName = formatTelecom(doc.id);
                final name = formatName(hostpital);
                 for (var doc in qrySnapshot.docs) {
                   if (doc.id.contains("Url")) {
                    final dataURL = doc.data() as Map<String, dynamic>; //converts snapshot to dict
                    queryContacts.add(EmergencyContactsModel(contactType: "AMBULANCE", telecom: telecomName, number: data["number"][0], contactName: name, url: dataURL["urlPic"][0]));
                   }
                 }
                
              }
            }
            
          }
        }
      }
      else {
        logger.e("Data doesnt exist...");
      }
    }
    catch (error) {
      logger.e("Error: ${error.toString()}");
      return;
    }
  }


  //gets number of BFP
  Future getBFPContacts(String municipality) async {
    CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection("hotlines").doc(municipality.toUpperCase()).collection("BFP_${municipality.toUpperCase()}_FIRE_STATION");

    try{
      QuerySnapshot qrySnapshot = await collection.get();
      //final data =  qrySnapshot.docs.map((doc) => doc.data());

      for (var doc in qrySnapshot.docs) {
        if (!doc.id.contains("Url")) {
          final data = doc.data() as Map<String, dynamic>; //converts snapshot to dict
          if (data["number"].length > 1) {
            for (var number in data["number"]){
              final telecomName = formatTelecom(doc.id);
              //gets url of image
              for (var doc in qrySnapshot.docs) {
                 if (doc.id.contains("Url")) {
                  final dataURL = doc.data() as Map<String, dynamic>; //converts snapshot to dict
                  queryContacts.add(EmergencyContactsModel(contactType: "BFP", telecom: telecomName, number: number, contactName: "BFP ${municipality.toUpperCase()} FIRE STATION", url: dataURL["urlPic"][0]));
                 }
              }
              
            }
          }
          else {
            final telecomName = formatTelecom(doc.id);
            for (var doc in qrySnapshot.docs) {
              if (doc.id.contains("Url")) {
                final dataURL = doc.data() as Map<String, dynamic>; //converts snapshot to dict
                queryContacts.add(EmergencyContactsModel(contactType: "BFP", telecom: telecomName, number: data["number"][0], contactName: "BFP ${municipality.toUpperCase()} FIRE STATION", url: dataURL["urlPic"][0]));
              }
            }
            
          }
        }
        
      }
    }
    catch (error) {
      logger.e("Error: ${error.toString()}");
    }
  }

  //get number of Coast guard
  Future getCoastContacts(String municipality) async {
    CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection("hotlines").doc(municipality.toUpperCase()).collection("DUMAGUIT_COAST_GUARD");

    try{
      QuerySnapshot qrySnapshot = await collection.get();
      //final data =  qrySnapshot.docs.map((doc) => doc.data());

      
      for (var doc in qrySnapshot.docs) {
        if (!doc.id.contains("Url")){
          final data = doc.data() as Map<String, dynamic>; //converts snapshot to dict
          if (data["number"].length > 1) {
            for (var number in data["number"]){
              //gets url of image
              for (var doc in qrySnapshot.docs) {
                if (doc.id.contains("Url")) {
                  final dataURL = doc.data() as Map<String, dynamic>; //converts snapshot to dict
                  queryContacts.add(EmergencyContactsModel(contactType: "COAST", telecom: "HOTLINE Cell Phone Number", number: number, contactName: "DUMAGUIT COAST GUARD", url: dataURL["urlPic"][0]));
                }
              }
              
            }
          }
          else {
            //gets url of image
            for (var doc in qrySnapshot.docs) {
              if (doc.id.contains("Url")) {
                final dataURL = doc.data() as Map<String, dynamic>; //converts snapshot to dict
                queryContacts.add(EmergencyContactsModel(contactType: "COAST", telecom: "HOTLINE Cell Phone Number", number: data["number"][0], contactName: "DUMAGUIT COAST GUARD", url: dataURL["urlPic"][0]));
              }
            }
            
          }
        }
        
      }
    }
    catch (error) {
      logger.e("Error: ${error.toString()}");
    }
  }

  void addToLocal() {
    getStoredCollection.updateData(queryContacts);
  }


}