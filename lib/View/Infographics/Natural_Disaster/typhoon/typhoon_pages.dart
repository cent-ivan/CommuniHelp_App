import 'package:flutter/material.dart';

import '../../../../ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';

class TyphoonPages extends ChangeNotifier {
  List<String> getList(String language, NaturalDisasterViewModel viewModel) {
    List<String>? typhoonList;
    switch (language) {
      case "EN":
        typhoonList = viewModel.assetEnglishPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "FIL":
        typhoonList = viewModel.assetFilipinoPaths[viewModel.disasterPath]?.sublist(1);
        break;
      case "AKL":
        typhoonList = viewModel.assetAklanonPaths[viewModel.disasterPath]?.sublist(1);
        break;
      default:
    }
    return typhoonList!;
  }
}