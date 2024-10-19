import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SnackBars {
  
  Future noConnection() async{
    Get.rawSnackbar(
        padding: EdgeInsets.symmetric(vertical: 7.r),
        messageText: Text(
          "Offline Mode. Not connected to the internet",
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.r,
            fontWeight: FontWeight.bold
          ),
        ),
        isDismissible: true,
        onTap: (snack) => Get.closeCurrentSnackbar(),
        duration: const Duration(days: 1),
        backgroundColor: Colors.amber.shade700,
        icon: Icon(
          Icons.wifi_off,
          color: Colors.white,
          size: 20.r,
        ),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING
    );
  }

  void closeSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
  }
}