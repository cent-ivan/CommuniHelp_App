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

  void loadData() {
    if (_contactbox.containsKey('CONTACTS')) {
      var gotContacts =_contactbox.get('CONTACTS')!;
      
      contacts = gotContacts;
      logger.i("comtact got $contacts");
    }
    else {
      //IF NULL
      _contactbox.put('CONTACTS', contacts);
      var gotContacts =_contactbox.get('CONTACTS')!;
      
      contacts = gotContacts;
    }
    
  }

  //adds to local box
  void updateData() {
    _contactbox.put('CONTACTS', contacts);
    logger.i("Contacs DB: Updated");
  }
}