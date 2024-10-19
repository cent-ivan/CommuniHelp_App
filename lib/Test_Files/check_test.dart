import 'package:logger/logger.dart';

class CheckTest {
  var logger = Logger();//showing debug messages


  void checkCGList(List cgList) {
    logger.d("Coast Guard List ${cgList.length}");
  }

  void displayCalled(String methodName) {
    logger.d(">>> $methodName called...");
  } 
}