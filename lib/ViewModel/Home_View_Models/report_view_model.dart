import 'dart:io';
import 'dart:typed_data';

import 'package:communihelp_app/Databases/FirebaseServices/FireStorageServices/report_storage.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class ReportViewModel extends ChangeNotifier {
  static final ReportViewModel _instance = ReportViewModel._internal();
  factory ReportViewModel() {
    return _instance;
  }

  ReportViewModel._internal();

  //report storage, lazy initializer
  ReportStorage? _reportStorage;
  ReportStorage? get reportStorage => _reportStorage ??= ReportStorage();

  //userData
  final userData = GetUserData();

  //controller
  final reportTitleController = TextEditingController();
  final locationController = TextEditingController();
  final contentController = TextEditingController();


  Logger logger = Logger(); //for debug message
  final _dialog = GlobalDialogUtil(); //dialgs 
  
  File? image; //edited image
  File? choosenImage;
  
  //Image profile picker GALLERY
  pickImage(imageSource, BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? file  = await picker.pickImage(source: imageSource);
      image = File(file!.path);
      notifyListeners();
    }
    catch (e) {
      if (context.mounted) {
        _dialog.unknownErrorDialog(context, "Image Error: ${e.toString()}");
      }
      
    }
    
  }

  //Crop Picture
  cropImage(File? image, BuildContext context) async {
    try {
      final ImageCropper cropper = ImageCropper();
      CroppedFile? croppedFile  = await cropper.cropImage(
        sourcePath: image!.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Color(0xFF57BEE6),
            toolbarTitle: "Crop Image",
            toolbarWidgetColor: Theme.of(context).colorScheme.surface,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
          )
        ]
      );
      File? croppedImage = File(croppedFile!.path);
      return croppedImage;
  
    }
    catch (e) {
      if (context.mounted) {
        _dialog.unknownErrorDialog(context, "Image Error: ${e.toString()}");
      }
      
    }
  }

  void changePicked(File? newImage) {
    choosenImage = newImage;
    notifyListeners();
  }

  void newImage(File? newImage) {
    image = newImage;
    notifyListeners();
  }


  //Firebase Storage methods------------------------------------------------------------
  Future<File> uint8ListToFile(Uint8List data, String filename) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/$filename";
    File file = File(path);
    return await file.writeAsBytes(data);
  }

  //sends to Firebase Storage of report (report_storage)
  Future postReport() async {
    String municipality = userData.municipality;
    String userName = userData.name;

    //format time
    DateTime utcNow = DateTime.now().toUtc();
    
    // Converting UTC to Philippine time 
    DateTime philippineTime = utcNow.add(Duration(hours: 8));
    
    DateFormat formatter = DateFormat('dd-MM-yyyy, hh:mm a', 'en_PH');
    
    String formattedDateTime = formatter.format(philippineTime);


    await reportStorage?.uploadReport(municipality, choosenImage!, userName, reportTitleController.text, locationController.text, contentController.text, formattedDateTime);
    
  }
}