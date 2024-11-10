import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class HiveDbSettings {
  Logger logger = Logger();
  
  Map<dynamic, dynamic> userSettings = {};
  


  //initiate hive box
  final _settings = Hive.box<Map<dynamic, dynamic>>('settingsbox');

  void loadData(String uid) {
    if (_settings.containsKey(uid)) {
      var gotSettings =_settings.get(uid)!;
      
      userSettings = gotSettings;
      logger.i("saved settings $userSettings");
      for (var key in _settings.keys) {
        logger.i("key : $key");
      }
      
    }
    else {
      //IF NULL
      Map<dynamic, dynamic> defaultSettings = {
        "language" : "En",
        "isLightmode" : true,
        "isDefault" : true //one time use
      };
      _settings.put(uid, defaultSettings);
      logger.i("Applied default settigs");
      var gotSettings =_settings.get(uid)!;
      
      userSettings = gotSettings;
    }
  }

  void addUserSettings(String language, bool lightmode, bool isDefault) {
    userSettings = {
      "language" : language,
      "isLightmode" : lightmode,
      "isDefault" : isDefault
    };
  }

  //putting data into local
  void updateData(String uid) {
    _settings.put(uid, userSettings);
    logger.i("Settings DB: Updated inside = $userSettings");
  }
}