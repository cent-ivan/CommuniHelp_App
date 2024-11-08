import 'package:communihelp_app/Databases/HiveServices/hive_db_contacts_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactsViewModel extends ChangeNotifier{
  final dbContact = HiveDbContactsUser();

  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  ContactsViewModel() {
    dbContact.loadData(curUser!.uid);
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

  void deleteContact(int index, String uid) {
    dbContact.contacts.removeAt(index);
    updateDB(uid);
  }

  //adds to list of contacts
  void addToContact() {
    //pass to db
    dbContact.addToContact({"Name" : editNameController.text , "Contact" : editNumberController.text});

    //sorts alphabetically
    dbContact.contacts.sort((a, b) {
      return a["Name"]!.compareTo(b["Name"]!);
    });

    updateDB(curUser!.uid);
    editNameController.clear();
    editNumberController.clear();

    notifyListeners();
  }

  //loads data from local db
  void loadDB(String uid) {
    dbContact.loadData(uid);
    notifyListeners();
  }

  //call to update new data
  void updateDB(String uid) {
    //sorts alphabetically
    dbContact.contacts.sort((a, b) {
      return a["Name"]!.compareTo(b["Name"]!);
    });
    dbContact.updateData(uid);
    notifyListeners();
  }
}