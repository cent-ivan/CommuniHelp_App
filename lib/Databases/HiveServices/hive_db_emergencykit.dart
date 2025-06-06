import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Model/Emergency_kit_model/emergency_kit_model.dart';

class ChecklistLocalDatabase{
  List storage = [
  ];

  List importantsList = [
    EmergencyKitModel(title: 'Bottled Water', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/water.png'),
    EmergencyKitModel(title: 'Canned Food', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/food.png'),
    EmergencyKitModel(title: 'First Aid Kit', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/firstaid.jpg'),
    EmergencyKitModel(title: 'Extra Money', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/money.jpg'),
    EmergencyKitModel(title: 'Prescription Medicines', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/medicine.jpg'),
    EmergencyKitModel(title: 'Hygiene Kit', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/hygiene.jpeg'),
    EmergencyKitModel(title: 'Battery Radio', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/phone.jpg'),
    EmergencyKitModel(title: 'Extra Clothes', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/clothes.jpg'),
    EmergencyKitModel(title: 'Important Documents(IDs, passport, Insurance papers)', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/documents.jpg'),
  ];


    //show current user
  User? user = FirebaseAuth.instance.currentUser;

  //initiate hive box
  final _emergencykitbox = Hive.box<List>('emergencykit');

  //loads before opening
  void loadData(String uid) async{
    var storedList = _emergencykitbox.get(uid);
    final keys = _emergencykitbox.keys;
    if (keys.contains(uid) && storedList != null) {
      //remove for deployment
      storage = storedList;
    }
    else {
      _emergencykitbox.put(uid, storage);
      var storedList = _emergencykitbox.get(uid);
      storage = storedList!;
    }
  }
    


  void updateData(String uid) {
    _emergencykitbox.put(uid, storage);
  }

  void reloadData() {
    storage = [];
  }

}
