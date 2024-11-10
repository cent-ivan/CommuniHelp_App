import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class HiveDbResSetting {
  Logger logger = Logger();
  
  Map<dynamic, dynamic> responderSettings = {};
  


  //initiate hive box
  final _settings = Hive.box<Map<dynamic, dynamic>>('ressettingsbox');

  void loadData(String uid) {
    if (_settings.containsKey(uid)) {
      var gotSettings =_settings.get(uid)!;
      
      responderSettings = gotSettings;
      logger.i("saved settings $responderSettings");
      for (var key in _settings.keys) {
        logger.i("key : $key");
      }
      
    }
    else {
      //IF NULL
      Map<dynamic, dynamic> defaultSettings = {
        "language" : "En",
        "'isLightmode'" : true,
        "isDefault" : true //one time use
      };
      _settings.put(uid, defaultSettings);
      logger.i("Applied default settigs");
      var gotSettings =_settings.get(uid)!;
      
      responderSettings = gotSettings;
    }
  }

  void addResponderSettings(String language, bool lightmode, bool isDefault) {
    responderSettings = {
      "language" : language,
      "isLightmode" : lightmode,
      "isDefault" : isDefault
    };
  }

  //putting data into local
  void updateData(String uid) {
    _settings.put(uid, responderSettings);
    logger.i("Settings DB: Updated inside = $responderSettings");
  }
}