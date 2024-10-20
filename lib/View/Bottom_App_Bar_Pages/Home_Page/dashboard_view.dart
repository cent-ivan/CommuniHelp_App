import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Home_Page/dashboard_components/announcement_section.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Home_Page/dashboard_components/dashboard_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,//if dark mode const Color(0xFF3D424A)
      body: SingleChildScrollView(
        key: const PageStorageKey<String>('DashboardView'),
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(9, 15, 9, 0).r,
          height: 1090.r,
          child:  Column(
            children: <Widget>[
    
              //ANNOUNCEMENT SECTION
              const AnnouncementSection(),
    
    
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(9, 28, 9, 9).r,
                child: Text(
                  "DASHBOARD",
                  style: TextStyle(
                    fontSize: 25.r,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline, 
                  ),
                ),
              ),
    
    
              //INFOGRAPHICS SECTION
              const InfographicsSection(), //Dashboard buttons
    
    
              //UTILITY SECTION
              const UtilitySection()
    
    
            ],
          )
        ),
      ),
    );
  }
}




