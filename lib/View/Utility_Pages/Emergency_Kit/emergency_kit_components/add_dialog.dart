import 'dart:io';
import 'package:communihelp_app/ViewModel/Home_View_Models/emergency_kit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AddChecklistDialog extends StatelessWidget {
  const AddChecklistDialog({
    super.key,
    required this.textController,
    required this.emergencyKitViewModel,
  });

  final TextEditingController textController;
  final EmergencyKitViewModel emergencyKitViewModel;

  @override
  Widget build(BuildContext context) {
    return Column
      (
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          child: Row(
            children: [
              
              //Input box for add dialog
              Expanded(
                child: TextField(
                  controller: textController,
                  style: const TextStyle(
                    color: Color(0xFF3D424A)
                  ),
              
                  decoration: InputDecoration(
                    hintText: 'Enter checklist',
                    hintStyle: const TextStyle(
                      color: Color(0xFF3D424A)
                    ),
                      border:  OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF3D424A),
                          width: 2.0.r,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0).r
                  ),
              
                ),
              ),
              
              SizedBox(height: 10.r,width: 10.r),
              
              //Button for picking an image
              MaterialButton(
                onPressed: emergencyKitViewModel.imageSelect,
                child: Image(
                  width: 40.r,
                  height: 40.r,
                  image: AssetImage('assets/images/dashboard/uploadphoto.png')
                )
              ),
            ],
          ),
        ),
        
    
        emergencyKitViewModel.image != null ? Image.file(File(emergencyKitViewModel.image!)) : Container(),
      ],
    );
  }
}
