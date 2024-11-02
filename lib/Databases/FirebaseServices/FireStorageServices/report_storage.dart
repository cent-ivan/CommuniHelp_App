import 'dart:io';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/post_report.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/report_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';


class ReportStorage {
  //Singleton pattern to avoid multiple instances
  static final ReportStorage _instance = ReportStorage._internal();
  factory ReportStorage() {
    return _instance;
  }
  ReportStorage._internal();

  Logger logger = Logger(); //for debug messages

  //profile view model, lazy initializer
  ReportViewModel? _viewModel;
  ReportViewModel get viewModel => _viewModel ??= ReportViewModel();



  //Firestore instance for update
  final firestoreService = PostReportService();
  
  //Firebase Storage
  final storageRef = FirebaseStorage.instance.ref();

  
  Future uploadReport(String municipality, File image, String userName, String reportName, String location, String content, String date) async {
    //final appDocDir = await getApplicationDocumentsDirectory(); //sample dela fterwards
    //logger.i("called: $appDocDir");
    String imagePath = "reports/${municipality.toUpperCase()}/${userName}_report_$date.jpg"; //generate unqique reference

    final profileRef = storageRef.child(imagePath); //create reference in the storage
    try {
      //uplaod the file
      await profileRef.putFile(image);

    }
    on FirebaseException catch (e) {
      logger.e("Firebase Error: ${e.toString()}");
    }

    String url = await profileRef.getDownloadURL();
    logger.d("After URL: $url");


    addReport(municipality, url, userName, reportName, location, content, date);
    
  }

  Future addReport(String municipality, String url, String userName, String repotrName, String location, String content, String date) async {
    firestoreService.uploadReport(municipality, location, userName, repotrName, content, url, date);

  }
  
}