import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_emergency_contacts.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Test_Files/check_test.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../Model/Emergency_contact_model/emergency_contacts_model.dart';

class EmergencyViewModel extends ChangeNotifier{
  var logger = Logger();//showing debug messages
  
  final getService = GetUserData(); //access data from firestore
  final getCollection = GetEmergencyContacts();

  final test = CheckTest();//TODO: remove in deployment

  String municipalityName = "No data";

  List<EmergencyContactsModel> mddrmoContacts = [];
  List<EmergencyContactsModel> ambulanceContacts = [];
  List<EmergencyContactsModel> bfpContacts = [];
  List<EmergencyContactsModel> cgContacts = [];
  


  void filterContact(){
    for (var contact in getCollection.queryContacts){
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
    test.displayCalled("reloadList"); //test for display
    getCollection.queryContacts = [];
    mddrmoContacts = [];
    ambulanceContacts = [];
    bfpContacts = [];
    cgContacts = [];
  }

  Future loadMunicipality() async {
    await getService.getUser();
    municipalityName = getService.municipality;
    if (getCollection.queryContacts.isEmpty){
      getCollection.getLDRRMOContacts(municipalityName);
      getCollection.getHostpitalContacts(municipalityName);
      getCollection.getBFPContacts(municipalityName);
      getCollection.getCoastContacts(municipalityName);
      await Future.delayed(Duration(seconds: 5, milliseconds: 5));
      filterContact();
      
    }
    else {
      getCollection.display();
    }

    notifyListeners();
  }

}