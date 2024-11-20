import 'package:flutter/material.dart';

import '../../../../ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';

class LandslidePages extends ChangeNotifier {
  List<String> getList(String language, NaturalDisasterViewModel viewModel) {
    List<String>? landslideList;
    switch (language) {
      case "EN":
        landslideList = viewModel.assetEnglishPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "FIL":
        landslideList = viewModel.assetFilipinoPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "AKL":
        landslideList = viewModel.assetFilipinoPaths[viewModel.disasterPath]?.sublist(1);
        break;
      default:
    }
    return landslideList!;
  }
}