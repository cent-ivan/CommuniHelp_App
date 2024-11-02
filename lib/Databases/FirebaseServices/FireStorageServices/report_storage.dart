import 'dart:io';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/post_report.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/report_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  
  Future uploadReport(String municipality, File image, String userName, String reportName, String location, String content, String date, BuildContext context) async {
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

    showFinsihed(context);

    addReport(municipality, url, userName, reportName, location, content, date);
    
  }

  Future addReport(String municipality, String url, String userName, String repotrName, String location, String content, String date) async {
    firestoreService.uploadReport(municipality, location, userName, repotrName, content, url, date);

  }

  void showFinsihed(BuildContext context) {
    showDialog(context: context, 
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("SENT"),
          titleTextStyle: TextStyle(
            fontSize: 20.r,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.outline
          ),
          children: [

            Padding(
              padding: EdgeInsets.all(12).r,
              child: SizedBox(
                height: 55.r,
                width: 55.r,
                child: Image.asset('assets/images/dashboard/sent.png')
              ),
            ),

            Center(
              child: Text("Report Sent!", 
              style: TextStyle(
                  fontSize: 16.r,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.outline
                )
              )
            ),
          ],
        );
      }
    );
  }
  
}