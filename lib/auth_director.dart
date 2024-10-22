import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class Director extends ChangeNotifier{
  Logger logger = Logger();

  //initiate hive box
  final _directorbox = Hive.box<bool>('director');

  bool isResponder = false;

  void loadDirection() {
    var storedValue = _directorbox.get('status');
    final keys = _directorbox.keys;
    if (keys.contains('status') && storedValue != null) {
      //remove for deployment
      isResponder = storedValue;
    }
    else {
      _directorbox.put('status', isResponder);
      var storedValue = _directorbox.get('status');
      isResponder = storedValue!;
    }
    isResponder = _directorbox.get('status')!;
  }

  //updates when called
  void changeDirection() {
    isResponder = !isResponder;
    notifyListeners();
    _directorbox.put('status', isResponder);
    logger.i("Is Responder: $isResponder");
    
  }
}