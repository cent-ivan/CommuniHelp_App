import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PollutionView extends StatefulWidget {
  const PollutionView({super.key});

  @override
  State<PollutionView> createState() => _PollutionViewState();
}

class _PollutionViewState extends State<PollutionView> {
  
  @override
  Widget build(BuildContext context) {
    //show current user
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEFEFEF),
        elevation: 1,
        title: Text(
             languageClass.systemLang["ManmadeInfo"]["Pollution"],
            style: TextStyle(
              color: Color(0xFF3D424A),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
            
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/images/infographics/exit_button.png', height: 35, width: 35,),
        )
      ),

      body: Placeholder(),

      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFEFEFEF),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  
                },
                child: Image.asset('assets/images/infographics/left-arrow.png', height: 35, width: 35,)
              ),
          
              SizedBox(
                width: 100,
                child: MaterialButton(
                  elevation: 0,
                  color: Color(0xFFFEAE49),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.r))
                  ),
                  onPressed: () {
                
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Color(0xFF3D424A),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
      
    );
  }
}