import 'package:flutter/material.dart';

import '../../../../ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';

class EarthquakePages extends ChangeNotifier {
  List<String> getList(String language, NaturalDisasterViewModel viewModel) {
    List<String>? earthquakeList;
    switch (language) {
      case "EN":
        earthquakeList = viewModel.assetEnglishPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "FIL":
        earthquakeList = viewModel.assetFilipinoPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "AKL":
        earthquakeList = viewModel.assetAklanonPaths[viewModel.disasterPath]?.sublist(1);
        break;
      default:
    }
    return earthquakeList!;
  }
}