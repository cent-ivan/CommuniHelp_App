import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class HiveDbContactsUser{
  Logger logger = Logger(); //diplay debug messages

  List<dynamic> contacts = [];

  //initiate hive box
  final _contactbox = Hive.box<List<dynamic>>('contactbox');

  void addToContact(Map<String, String> data) {
    contacts.add(data);
  }

  void deleteKeys() {
    _contactbox.deleteAll(_contactbox.keys);
    logger.i("Deleted all");
  }

  void loadData(String uid) {
    if (_contactbox.containsKey(uid)) {
      var gotContacts =_contactbox.get(uid)!;
      
      contacts = gotContacts;
      logger.i("comtact got $contacts");
      for (var key in _contactbox.keys) {
        logger.i("key : $key");
      }
      
    }
    else {
      //IF NULL
      _contactbox.put(uid, contacts);
      var gotContacts =_contactbox.get(uid)!;
      
      contacts = gotContacts;
    }
    
  }

  //adds to local box
  void updateData(String uid) {
    _contactbox.put(uid, contacts);
    logger.i("Contacs DB: Updated");
  }
}