import 'dart:io';
import 'package:communihelp_app/Databases/FirebaseServices/FireStorageServices/profile_storage.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class PickProfileDialog {
  Logger logger = Logger(); //for debug message
  //final _dialog = GlobalDialogUtil(); //dialgs 

  final userData = GetUserData();
  final profileService = ProfileStorage();

  //shows dialog for picking
  showPickScreen(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) {
        final viewModel = Provider.of<ProfileViewModel>(context);
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text("Image Picker"),
          children: [
            viewModel.image != null ? 
            //if not null image
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Image.file(viewModel.image!, height: 200.r, width: 200.r, fit: BoxFit.cover,),
                ),

                SizedBox(height: 15.r,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //UPLOAD
                    MaterialButton(
                      height: 25.r,
                      minWidth: 40.r,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.r))
                      ),
                      color: Color(0xFFFEAE49),
                      onPressed: () async {
                        //profileService.uploadProfile(viewModel.image!, userData.uid);
                        viewModel.changeEditProfile(viewModel.image);
                        viewModel.image = null;

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.r,
                          color: Theme.of(context).colorScheme.outline
                        ),
                      ),
                    ),

                    SizedBox(width: 5.r,),

                    //CROP
                    MaterialButton(
                      height: 25.r,
                      minWidth: 40.r,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.r))
                      ),
                      color: Color(0xFF57BEE6),
                      onPressed: () async {
                        try {
                          File croppedImage = await viewModel.cropImage(viewModel.image, context);
                          viewModel.newImage(croppedImage);
                        } catch (e) {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                          
                        }
                        
                        
                      },
                      child: Text(
                        "Crop",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.r,
                          color: Theme.of(context).colorScheme.outline
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ) :
            // else display text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25).r,
              child: Text("Pick your profile picture"),
            ),

            SizedBox(height: 25.r,),
  
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 25.r,
                  minWidth: 40.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.r))
                  ),
                  color: Color(0xFF57BEE6),
                  onPressed: () async {
                    try {
                      File imagePicked = await viewModel.pickImage(ImageSource.camera, context);
                      viewModel.image = imagePicked;

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                    
                  },
                  child: Text(
                    "Open Camera",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.r,
                      color: Theme.of(context).colorScheme.outline
                    ),
                  ),
                ),

                SizedBox(width: 5.r,),

                MaterialButton(
                  height: 25.r,
                  minWidth: 40.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.r))
                  ),
                  color: Color(0xFF57BEE6),
                  onPressed: () async {
                    try {
                      File imagePicked = await viewModel.pickImage(ImageSource.gallery, context);
                      viewModel.image = imagePicked;

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                    catch (e) {
                      logger.i("Catched");
                    }
                    
                  },
                  child: Text(
                    "Open Gallery",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.r,
                      color: Theme.of(context).colorScheme.outline
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    viewModel.image = null;
                    Navigator.pop(context);
                  }, 
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.r,
                      color: Theme.of(context).colorScheme.outline
                    ),
                  ),
                )

              ],
            ),

            


          ],
        );
      }
    );
  }
}