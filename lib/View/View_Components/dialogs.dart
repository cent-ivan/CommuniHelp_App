import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalDialogUtil{
  //loading screen
  void circularProgress(context){
    showDialog(
      barrierColor: Color(0xFFFFFFFF),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r))
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.outline,
              ),

              const SizedBox(width: 8,),

              const Text("Error"),
            ],
          ),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),

          contentPadding: const EdgeInsets.only(left: 2),
          content: Container(
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            height: 120,
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
      barrierColor: Color(0x80FFFFFF),
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
                color: Colors.black,
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
      barrierColor: Color(0x80FFFFFF),
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

  //signing out screen
  void noLocationDialog(context){
    showDialog(
      barrierColor: Colors.black26,
      context: context, 
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.r),)
          ),
          backgroundColor: const Color(0xF2FCFCFC),
          elevation: 0,
          contentPadding: EdgeInsets.all(12).r,
          children: [
              Center(child: Icon(Icons.location_disabled, size: 20.r,color: Color(0xFF3D424A))),
          
              SizedBox(height: 15,), //const Color(0xF2FCFCFC)
          
              Center(
                child: Text(
                  "No selected evacuation site",
                  style: TextStyle(
                    color: Color(0xFF3D424A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
          ],
        );
      }
    );
  }


  void showWaiting(BuildContext context) {
    showDialog(context: context, 
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("Waiting for verification"),
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
                child: Image.asset('assets/images/dashboard/changed.png')
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12).r,
              child: Center(
                child: Text("Check your new email for verfication link. Clink the link", 
                style: TextStyle(
                    fontSize: 16.r,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline
                  )
                )
              ),
            ),
          ],
        );
      }
    );
  }


  void showPassChange(BuildContext context) {
    showDialog(context: context, 
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("Password Changed"),
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
                child: Image.asset('assets/images/dashboard/changed.png')
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12).r,
              child: Center(
                child: Text("You password has been changed!", 
                style: TextStyle(
                    fontSize: 16.r,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline
                  )
                )
              ),
            ),
          ],
        );
      }
    );
  }

}