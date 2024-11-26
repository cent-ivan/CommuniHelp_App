import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_emergency_contacts.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/ViewModel/Connection_Controller/Controller/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../Databases/HiveServices/hive_db_emergencycontact.dart';
import '../../Model/Emergency_contact_model/emergency_contacts_model.dart';

class EmergencyViewModel extends ChangeNotifier{
  var logger = Logger();//showing debug messages
  final NetworkController network =  Get.put(NetworkController()); //checksconnction
  
  //final getService = GetUserData(); //access data from firestore
  final getCollection = GetEmergencyContacts();
  final getStoredCollection = EmergencyContactLocalDatabase();
  bool isNew = true;

  int loadTries = 2;


  String municipalityName = "No data";

  List<EmergencyContactsModel> mddrmoContacts = [];
  List<EmergencyContactsModel> ambulanceContacts = [];
  List<EmergencyContactsModel> bfpContacts = [];
  List<EmergencyContactsModel> cgContacts = [];
  
  void changeNew() {
    isNew = !isNew;
  
  }

  void filterContact(){
    if (network.isOnline.value){
      onlineFilter();
    }
    else {
      offlineFilter();
    }
  }

  void onlineFilter(){
    for (var contact in getCollection.queryContacts){
      logger.i("Inside Hive: $contact");
      if (contact.contactType!.contains("LDRRMO")) {
        mddrmoContacts.add(contact);
        notifyListeners();
      }
      else if (contact.contactType!.contains("AMBULANCE")){
        ambulanceContacts.add(contact);
        notifyListeners();
      }
      else if (contact.contactType!.contains("BFP")) {
        bfpContacts.add(contact);
        notifyListeners();
      }
      else if (contact.contactType!.contains("COAST")) {
        cgContacts.add(contact);
        notifyListeners();
      }
      else {
        return;
      }
    }
  }

  void offlineFilter() {
    logger.i("Offline");
    for (var contact in getStoredCollection.queryContacts){
      logger.i("Inside Hive: $contact");
      if (contact.contactType!.contains("LDRRMO")) {
        mddrmoContacts.add(contact);
        notifyListeners();
      }
      else if (contact.contactType!.contains("AMBULANCE")){
        ambulanceContacts.add(contact);
        notifyListeners();
      }
      else if (contact.contactType!.contains("BFP")) {
        bfpContacts.add(contact);
        notifyListeners();
      }
      else if (contact.contactType!.contains("COAST")) {
        cgContacts.add(contact);
        notifyListeners();
      }
      else {
        return;
      }
    }
  }


  void reloadLists() {
    getCollection.queryContacts.clear();
    getStoredCollection.reloadData();
    mddrmoContacts.clear();
    ambulanceContacts.clear();
    bfpContacts.clear();
    cgContacts.clear();
    
    notifyListeners();
  }

  Future loadMunicipality(BuildContext context) async {
    final userData = Provider.of<GetUserData>(context, listen: false);
    await userData.getUser();
    try {
      municipalityName = userData.municipality;
      if (getCollection.queryContacts.isEmpty){
        getCollection.getLDRRMOContacts(municipalityName);
        await Future.delayed(Duration(seconds: 3, milliseconds: 500));
        getCollection.getHostpitalContacts(municipalityName);
        await Future.delayed(Duration(seconds: 2, milliseconds: 300));
        getCollection.getBFPContacts(municipalityName);
        getCollection.getCoastContacts(municipalityName);
        await Future.delayed(Duration(seconds: 2, milliseconds: 500));
        getStoredCollection.loadData();
        filterContact();
        getCollection.addToLocal(); //adds the newly get contacts from firestore to Hive db
      }
      else {
        logger.d("Exists..");
      }
    }
    catch (e) {
      logger.e("Try Again.");
      if (loadTries != 0) {
        if (context.mounted) {
          loadMunicipality(context);
          loadTries -= 1;
          notifyListeners();
        }
        else {
          logger.e("Nope");
        }
        
      }
    }
    

    notifyListeners();
  }

}