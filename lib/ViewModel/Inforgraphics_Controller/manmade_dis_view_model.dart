import 'package:flutter/material.dart';


class ManMadeDisasterViewModel extends ChangeNotifier{
  String? pageTitle;
  String? disasterPath;
  String? userLanguage;

  final Map<String, List<String>> assetEnglishPaths = {
    "Vehicular" : [
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular1.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular2.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular3.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular4.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular5.png",
    ],
    "Burn" : [
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn1.png",
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn2.png",
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn3.png",
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn4.png",
    ],
    "Structural" : [
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural1.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural2.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural3.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural4.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural5.png",
    ],
    "Pollution" : [
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution1.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution2.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution3.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution4.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution5.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution6.png",
    ]
  };

  void getPath(String disaster, String language) {
    userLanguage = language;
    //check the user language first
    if (language.contains("En")) {
      for (String key in assetEnglishPaths.keys) {
        if (disaster.contains(key)) {
          disasterPath = key;
          notifyListeners();
        }
      }
    }
  }
  
}