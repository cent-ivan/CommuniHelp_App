import 'package:communihelp_app/Models/emergency_contacts_model.dart';
import 'package:flutter/material.dart';

class EmergencyViewModel extends ChangeNotifier{

  EmergencyViewModel(){
    addContact();
  }

  final String municipalityName = "Nabas";

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

}