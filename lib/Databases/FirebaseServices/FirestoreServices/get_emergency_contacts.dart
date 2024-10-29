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
            queryContacts.add(EmergencyContactsModel(contactType: "LDRRMO", municipality: municipality, number: number, contactName: "$telecomName: $municipality LDRRMO"));
          }
        }
        else {
          final telecomName = formatTelecom(doc.id);
          queryContacts.add(EmergencyContactsModel(contactType: "LDRRMO", municipality: municipality, number: data["number"][0], contactName: "$telecomName: $municipality LDRRMO"));
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
            final data = doc.data() as Map<String, dynamic>; //converts snapshot to dict
            if (data["number"].length > 1) {
              for (var number in data["number"]){
                final telecomName = formatTelecom(doc.id);
                final name = formatName(hostpital);
                queryContacts.add(EmergencyContactsModel(contactType: "AMBULANCE", municipality: municipality, number: number, contactName: "$telecomName: $name"));
              }
            }
            else {
              final telecomName = formatTelecom(doc.id);
              final name = formatName(hostpital);
              queryContacts.add(EmergencyContactsModel(contactType: "AMBULANCE", municipality: municipality, number: data["number"][0], contactName: "$telecomName: $name"));
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
        final data = doc.data() as Map<String, dynamic>; //converts snapshot to dict
        if (data["number"].length > 1) {
          for (var number in data["number"]){
            final telecomName = formatTelecom(doc.id);
            queryContacts.add(EmergencyContactsModel(contactType: "BFP", municipality: municipality, number: number, contactName: "$telecomName: BFP ${municipality.toUpperCase()} FIRE STATION"));
          }
        }
        else {
          final telecomName = formatTelecom(doc.id);
          queryContacts.add(EmergencyContactsModel(contactType: "BFP", municipality: municipality, number: data["number"][0], contactName: "$telecomName: BFP ${municipality.toUpperCase()} FIRE STATION"));
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
        final data = doc.data() as Map<String, dynamic>; //converts snapshot to dict
        if (data["number"].length > 1) {
          for (var number in data["number"]){
            final telecomName = formatTelecom(doc.id);
            queryContacts.add(EmergencyContactsModel(contactType: "COAST", municipality: municipality, number: number, contactName: "$telecomName: DUMAGUIT COAST GUARD"));
          }
        }
        else {
          final telecomName = formatTelecom(doc.id);
          queryContacts.add(EmergencyContactsModel(contactType: "COAST", municipality: municipality, number: data["number"][0], contactName: "$telecomName: DUMAGUIT COAST GUARD"));
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