import 'package:communihelp_app/Models/emergency_kit_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmergencyKitViewModel extends ChangeNotifier {
  List<EmergencyKitModel> importantsList = [
    EmergencyKitModel(title: 'Bottled Water', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/water.jpg'),
    EmergencyKitModel(title: 'Canned Food', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/food.jpg'),
    EmergencyKitModel(title: 'First Aid Kit', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/firstaid.jpg'),
    EmergencyKitModel(title: 'Extra cash', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/money.jpg'),
    EmergencyKitModel(title: 'Prescription medicines', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/medicine.jpg'),
    EmergencyKitModel(title: 'Hygiene kit', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/hygiene.jpeg'),
    EmergencyKitModel(title: 'Radyo de baterya', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/phone.jpg'),
    EmergencyKitModel(title: 'Extra clothes', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/clothes.jpg'),
    EmergencyKitModel(title: 'Mga importanteng documento (national id, passport, birth certificate)', isChecked: false, imagePath: 'assets/images/dashboard/checklist_images/documents.jpg'),
  ];

  //image picker datatype
  XFile? image;

  //checkbox clicking checkbox
  void checkBoxChanged(int index, bool? value)
  {
    importantsList[index].isChecked = value;
    notifyListeners();
  }

  //Image select
  Future<void> imageSelect() async
  {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    image = pickedImage;
    notifyListeners();
  }

  //adding a checklist to the list
  void addItem(String itemName, BuildContext context) {
    importantsList.add(EmergencyKitModel(title: itemName, isChecked: false, imagePath: image));
    notifyListeners();
    Navigator.of(context).pop();
  }

  //deletes an item
  void deleteitem(int index)
  {
    importantsList.removeAt(index);
    notifyListeners();
  }

  
}