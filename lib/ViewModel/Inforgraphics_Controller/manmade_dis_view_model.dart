import 'package:flutter/material.dart';


class ManMadeDisasterViewModel extends ChangeNotifier{
  String? coverPath;
  String? disasterDialog;
  String? disasterPath;
  String? userLanguage;

  final Map<String, List<String>> assetEnglishPaths = {
    "VEHICULAR" : [
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular1_cover_En.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular1.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular2.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular3.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular4.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_En/Vehicular5.png",
    ],
    "BURN" : [
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn1_cover_En.png",
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn1.png",
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn2.png",
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn3.png",
      "assets/images/infographics/manmade_infographics/burn/burn_En/Burn4.png",
    ],
    "STRUCTURAL" : [
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural1_cover_En.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural1.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural2.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural3.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural4.png",
      "assets/images/infographics/manmade_infographics/structural/structural_En/Structural5.png",
    ],
    "POLLUTION" : [
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution1_cover_En.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution1.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution2.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution3.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution4.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution5.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_En/Pollution6.png",
    ]
  };


  final Map<String, List<String>> assetFilipinoPaths = {
    "VEHICULAR" : [
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Fil/Aksidente1_cover_Fil.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Fil/Aksidente1.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Fil/Aksidente2.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Fil/Aksidente3.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Fil/Aksidente4.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Fil/Aksidente5.png",
    ],
    "BURN" : [
      "assets/images/infographics/manmade_infographics/burn/burn_Fil/Sunog1_cover_Fil.png",
      "assets/images/infographics/manmade_infographics/burn/burn_Fil/Sunog1.png",
      "assets/images/infographics/manmade_infographics/burn/burn_Fil/Sunog2.png",
      "assets/images/infographics/manmade_infographics/burn/burn_Fil/Sunog3.png",
      "assets/images/infographics/manmade_infographics/burn/burn_Fil/Sunog4.png",
    ],
    "STRUCTURAL" : [
      "assets/images/infographics/manmade_infographics/structural/structural_Fil/Istruktura1_cover_Fil.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Fil/Istruktura1.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Fil/Istruktura2.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Fil/Istruktura3.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Fil/Istruktura4.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Fil/Istruktura5.png",
    ],
    "POLLUTION" : [
      "assets/images/infographics/manmade_infographics/pollution/pollution_Fil/Polusyon1_cover_Fil.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Fil/Polusyon1.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Fil/Polusyon2.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Fil/Polusyon3.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Fil/Polusyon4.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Fil/Polusyon5.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Fil/Polusyon6.png",
    ]
  };

  final  Map<String, List<String>> assetAklanonPaths = {
    "VEHICULAR" : [
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Akl/Accident1_cover_Akl.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Akl/Accident1.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Akl/Accident2.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Akl/Accident3.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Akl/Accident4.png",
      "assets/images/infographics/manmade_infographics/vehicular/vehicular_Akl/Accident5.png",
    ],
    "STRUCTURAL" : [
      "assets/images/infographics/manmade_infographics/structural/structural_Akl/Structural1_cover_Akl.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Akl/Structural1.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Akl/Structural2.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Akl/Structural3.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Akl/Structural4.png",
      "assets/images/infographics/manmade_infographics/structural/structural_Akl/Structural5.png",
    ],
    "POLLUTION" : [
      "assets/images/infographics/manmade_infographics/pollution/pollution_Akl/Water1_cover_Akl.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Akl/Water1.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Akl/Water2.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Akl/Water3.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Akl/Water4.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Akl/Water5.png",
      "assets/images/infographics/manmade_infographics/pollution/pollution_Akl/Water6.png",
    ]
  };

  void getPath(String disaster, String language) {
    userLanguage = language;
    if (language.toLowerCase() == "en" ) {
      for (String key in assetEnglishPaths.keys) {
        if (disaster.toUpperCase() == key) {
          coverPath = assetEnglishPaths[key]?[0]; //gets the cover path in the path list
          disasterPath = key;
          _getDisasterDialog(disasterPath!); //gets the dialog in user setting
          notifyListeners();
        }
      }
    }
    else if (language.toLowerCase() == "fil" ) {
      for (String key in assetFilipinoPaths.keys) {
        if (disaster.toUpperCase() == key) {
          coverPath = assetFilipinoPaths[key]?[0];
          disasterPath = key;
          _getDisasterDialog(disasterPath!); //gets the dialog in user setting
          notifyListeners();
        }
      }
    }
    else if (language.toLowerCase() =="akl" ) {
      for (String key in assetAklanonPaths.keys) {
        if (disaster.toUpperCase() == key) {
          coverPath = assetAklanonPaths[key]?[0];
          disasterPath = key;
          _getDisasterDialog(disasterPath!); //gets the dialog in user setting
          notifyListeners();
        }
      }
    }
  }

  void _getDisasterDialog(String disaster) {
    if (disaster == "VEHICULAR") {
      disasterDialog = "AccidentDialog";
      notifyListeners();
    }
    else if (disaster == "BURN") {
      disasterDialog = "FireDialog";
      notifyListeners();
    }
    else if (disaster == "STRUCTURAL") {
      disasterDialog = "FailureDialog";
      notifyListeners();
    }
    else if (disaster == "POLLUTION") {
      disasterDialog = "PollutionDialog";
      notifyListeners();
    }
    else {
      disasterDialog = "None";
    }
  }
  
}