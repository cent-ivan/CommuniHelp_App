import 'package:communihelp_app/CommuniHelp_Responder/View/Home_View/dashboard_components/announcement_section.dart';
import 'package:communihelp_app/CommuniHelp_Responder/View/Home_View/dashboard_components/utility_buttons.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/responder_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponderDashboardView extends StatefulWidget {
  const ResponderDashboardView({super.key});

  @override
  State<ResponderDashboardView> createState() => _ResponderDashboardViewState();
}

class _ResponderDashboardViewState extends State<ResponderDashboardView> {
  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final themeSettings = ResponderSettingViewModel();
    themeSettings.loadSettings(curUser!.uid);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,//if dark mode const Color(0xFF3D424A)
      body: SingleChildScrollView(
        key: const PageStorageKey<String>('ResponderDashboardView'),
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(9, 8, 9, 0).r,
          height: 780.r,
          child:  Column(
            children: <Widget>[
    
              //ANNOUNCEMENT SECTION
              const ResponderAnnouncement(),
    
    
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(9, 20, 9, 9).r,
                child: Text(
                  "DASHBOARD",
                  style: TextStyle(
                    fontSize: 25.r,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline, 
                  ),
                ),
              ),
    
    
              //UTILITY SECTION
              ResponderUtilityButtons()
    
    
            ],
          )
        ),
      ),
    );
  }
}