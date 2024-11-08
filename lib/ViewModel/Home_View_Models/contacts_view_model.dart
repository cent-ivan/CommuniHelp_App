import 'package:communihelp_app/Databases/HiveServices/hive_db_contacts_user.dart';
import 'package:flutter/material.dart';

class ContactsViewModel extends ChangeNotifier{
  final dbContact = HiveDbContactsUser();


  ContactsViewModel() {
    dbContact.loadData();
    notifyListeners();
  }


  final searchController = TextEditingController(); //controller for search field
  final editNameController = TextEditingController();//for edit name
  final editNumberController = TextEditingController();//for edit name

  void changeName(int index) {
    dbContact.contacts[index]["Name"] = editNameController.text; 
  }

  void changeContact(int index) {
    dbContact.contacts[index]["Contact"] = editNumberController.text; 
  }

  void deleteContact(int index) {
    dbContact.contacts.removeAt(index);
    updateDB();
  }

  //adds to list of contacts
  void addToContact() {
    //pass to db
    dbContact.addToContact({"Name" : editNameController.text , "Contact" : editNumberController.text});

    //sorts alphabetically
    dbContact.contacts.sort((a, b) {
      return a["Name"]!.compareTo(b["Name"]!);
    });

    updateDB();
    editNameController.clear();
    editNumberController.clear();

    notifyListeners();
  }

  //loads data from local db
  void loadDB() {
    dbContact.loadData();
    notifyListeners();
  }

  //call to update new data
  void updateDB() {
    //sorts alphabetically
    dbContact.contacts.sort((a, b) {
      return a["Name"]!.compareTo(b["Name"]!);
    });
    dbContact.updateData();
    notifyListeners();
  }
}