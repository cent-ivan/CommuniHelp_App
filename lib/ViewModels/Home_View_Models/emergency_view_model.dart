import 'package:communihelp_app/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Models/emergency_contacts_model.dart';
import 'package:flutter/material.dart';

class EmergencyViewModel extends ChangeNotifier{
  final getService = GetUserData(); //access data from firestore

  EmergencyViewModel(){
    addContact();
  }

  String municipalityName = "No data";

  List<EmergencyContactsModel> queryContacts = [];
  List<EmergencyContactsModel> mddrmoContacts = [];
  List<EmergencyContactsModel> ambulanceContacts = [];
  List<EmergencyContactsModel> bfpContacts = [];
  

  void addContact(){
    queryContacts.add(EmergencyContactsModel(contactType: "MDRRMO", number: "0912345678190", contactName: "TNT - MDRRMO Nabas"));
    queryContacts.add(EmergencyContactsModel(contactType: "MDRRMO", number: "0912345678190", contactName: "GLOBE - MDRRMO Nabas"));

    queryContacts.add(EmergencyContactsModel(contactType: "AMBULANCE", number: "0912345678121", contactName: "TNT - Ambulance Nabas"));
    queryContacts.add(EmergencyContactsModel(contactType: "BFP", number: "0912345678199", contactName: "TNT - BFP Nabas"));
    notifyListeners();

    filterContact();
  }

  void filterContact(){
    for (var contact in queryContacts){
      if (contact.contactType!.contains("MDRRMO")) {
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
      else {
        return;
      }
    }
  }

  Future loadMunicipality() async {
    await getService.getUser();
    municipalityName = getService.municipality;
    notifyListeners();
  }

}