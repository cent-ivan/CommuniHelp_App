import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Models/emergency_kit_model.dart';

class LocalDatabase{
  List storage = [
  ];

  List importantsList = [
    EmergencyKitModel(title: 'Bottled Water', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/water.png'),
    EmergencyKitModel(title: 'Canned Food`', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/food.png'),
    EmergencyKitModel(title: 'First Aid Kit', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/firstaid.jpg'),
    EmergencyKitModel(title: 'Extrang pera', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/money.jpg'),
    EmergencyKitModel(title: 'Prescription medicines', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/medicine.jpg'),
    EmergencyKitModel(title: 'Hygiene kit', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/hygiene.jpeg'),
    EmergencyKitModel(title: 'Radyo de baterya', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/phone.jpg'),
    EmergencyKitModel(title: 'Extrang damit', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/clothes.jpg'),
    EmergencyKitModel(title: 'Mga importanteng dokyumento (national id, passport, birth certificate)', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/documents.jpg'),
  ];


    //show current user
  User? user = FirebaseAuth.instance.currentUser;

  //initiate hive box
  final _emergencykitbox = Hive.box<List>('emergencykit');


  void loadData(String uid) async{
    print("loaded..");
    var storedList = _emergencykitbox.get(uid);
    final keys = _emergencykitbox.keys;
    if (keys.contains(uid) && storedList != null) {
      print("True $uid");
      print("True $storage");
      //remove for deployment
      print(storedList.length);
      storage = storedList;
      for (var model in storage) {
        print(model.title);
      }
    }
    else {
      print("reloaded..");
      _emergencykitbox.put(uid, storage);
      var storedList = _emergencykitbox.get(uid);
      storage = storedList!;
    }
  }
    


  void updateData(String uid) {
    print("updated... put($uid,$storage)");
    _emergencykitbox.put(uid, storage);
  }

  void reloadData() {
    print("reloaded..");
    storage = [];
  }

}
