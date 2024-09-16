import 'dart:io';
import 'package:communihelp_app/ViewModels/Home_View_Models/emergency_kit_view_model.dart';
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
    return SingleChildScrollView(
      child: Column
        (
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
                color: const Color(0xFF3D424A),
                onPressed: emergencyKitViewModel.imageSelect,
                child: const Icon(
                  Icons.image,
                  color: Color(0xFFF5F5F5),
                ),
              ),
            ],
          ),
          
      
          emergencyKitViewModel.image != null ? Image.file(File(emergencyKitViewModel.image!.path)) : Container(),
        ],
      ),
    );
  }
}
