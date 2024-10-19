import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/HiveServices/hive_db_emergencykit.dart';
import 'package:communihelp_app/Models/Emergency_kit_model/emergency_kit_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmergencyKitViewModel extends ChangeNotifier {
  ChecklistLocalDatabase db = ChecklistLocalDatabase(); //access local db methods

  GetUserData getService = GetUserData();
  late String uid = "";

  //image picker datatype
  String? image;

  void loadData(String uid) {
    db.loadData(uid);
    notifyListeners();
  }


  //checkbox clicking checkbox
  void checkBoxChangedStorage(int index, bool? value)
  {
    checkUser();
    db.storage[index].isChecked = value;
    db.updateData(uid);
    notifyListeners();
  } 

  //checkbox clicking checkbox
  void checkBoxChangedImportant(int index, bool? value)
  {
    checkUser();
    db.importantsList[index].isChecked = value;
    db.updateData(uid);
    notifyListeners();
  } 
 
  //Image select
  Future<void> imageSelect() async
  {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (pickedImage != null) {
      image = pickedImage.path;
    }
    else {
      image = 'assets/images/dashboard/checklist_images/no_pictures.png';
    }
    notifyListeners();
  }

  //adding a checklist to the list
  void addItem(String itemName, BuildContext context) {
    checkUser();
    db.storage.add(EmergencyKitModel(title: itemName, isChecked: false, imagePath: image));
    db.updateData(uid);
    notifyListeners();
    Navigator.pop(context);
  }

  //deletes an item
  void deleteitem(int index)
  {
    checkUser();
    db.storage.removeAt(index);
    db.updateData(uid);
    notifyListeners();
  }

  //checls first
  void checkUser() {
    uid = getService.user?.uid ?? '';
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      if (newUser != null) {
        if (uid != newUser.uid) {
          db.reloadData();
          uid =  newUser.uid;
          notifyListeners();
        }
        else {
          uid = getService.user!.uid;
          notifyListeners();
        }
      }
    });
  }
}