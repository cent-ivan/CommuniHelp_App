import 'package:flutter/material.dart';

class GlobalDialogUtil{
  //loading screen
  void circularProgress(context){
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 6,
            color: Color(0xFF57BEE6),
          ),
        );
      }
    );
  }

  //removes dialog
  void removeDialog(context) {
    Navigator.pop(context);
  }
}