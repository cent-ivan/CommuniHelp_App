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

  //dialog for catched errors
  void unknownErrorDialog(BuildContext context , String message){
    showDialog(context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.outline,
              ),

              const SizedBox(width: 8,),

              const Text("Unknown Error"),
            ],
          ),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),

          contentPadding: const EdgeInsets.only(left: 2),
          content: Container(
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            height: 95,
            child: Text(
              message,
              style: const TextStyle(
              fontSize: 16,
            ),
          ),
          ),
        );
      },
    );
  }

  //signing out screen
  void circularLoggingIn(context){
    showDialog(
      context: context, 
      builder: (context) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 6,
              color: Color(0xFF57BEE6),
            ),

            SizedBox(height: 15,),
        
            Text(
              "Logging In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        );
      }
    );
  }

  //signing out screen
  void circularSignout(context){
    showDialog(
      context: context, 
      builder: (context) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 6,
              color: Color(0xFF57BEE6),
            ),

            SizedBox(height: 15,),
        
            Text(
              "Signing Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        );
      }
    );
  }
}