import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class EmergencyContactLocalDatabase {
  Logger logger = Logger();//for debug messages

  List queryContacts = [];
  //initiate hive box
  final _emergencybox = Hive.box<List>('emergencycontact');

  //loads before opening
  void loadData() {
    var storedList = _emergencybox.get('contacts');
    final keys = _emergencybox.keys;
    if (keys.contains('contacts') && storedList != null) {
      queryContacts = storedList;
    }
    else {
      _emergencybox.put('contacts', queryContacts);
      var storedList = _emergencybox.get('contacts');
      queryContacts = storedList!;
    }
  }
  

  void updateData(List storage) {
    logger.i("Updated Local Emergency Contacts");
    _emergencybox.put('contacts', storage);
  }

  void reloadData() {
    queryContacts = [];
  }
}