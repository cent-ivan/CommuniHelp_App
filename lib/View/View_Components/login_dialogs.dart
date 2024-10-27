import 'package:flutter/material.dart';

class LoginDialogs {
  void displayMessage(BuildContext context, String message) {
    //edit the design
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xF2FCFCFC),
          title: const Text(
              "Login failed",
              style: TextStyle(
              color: Color(0xFF3D424A)
            ),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),

        contentPadding: const EdgeInsets.only(left: 2),
        content: Container(
        padding: const EdgeInsets.only(left: 18, top: 25, right: 18),
        height: 110,
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF3D424A)
          ),
        ),
      ),
    );
  },
  );
  }
}