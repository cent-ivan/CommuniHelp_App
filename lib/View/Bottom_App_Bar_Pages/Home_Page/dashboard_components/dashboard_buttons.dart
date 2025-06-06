//Infographics Section
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Home_Page/dashboard_components/utility_buttons.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfographicsSection extends StatelessWidget {
  const InfographicsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //show current user
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);
    return Container(
      height: 215.r,
      padding: const EdgeInsets.all(10).r,
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 12).r,
      decoration: BoxDecoration(
        color:  const Color(0x80A4EACD),
        borderRadius: BorderRadius.all(Radius.circular(18.r))
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(8, 3, 8, 6).r,
            child: Text(
              "Infographics",
              style: TextStyle(
                fontSize: 20.r,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.outline, 
              ),
            ),
          ),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              Column(
                children: [
                  
                  //Natural Disaster Button
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context,'/naturalinfo');
                    },
                    height: 100.r,
                    minWidth: 135.r,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.r))
                    ),
                    color: const Color(0xFFF2F2F2),
                    splashColor: const Color(0xFFB9EFD8),
                    elevation: 3,
                    child: Image(
                      width: 55.r,
                      image: const  AssetImage('assets/images/dashboard/natural.png')
                    )
                  ),
          
                  SizedBox(height: 15.r,),
          
                  Text(
                    languageClass.systemLang["Home"]["NaturalDis"],
                    style: TextStyle(
                      fontSize: 11.r,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ],
              ),
              
              SizedBox(width: 10.r,),
          
              Column(
                children: [
                  
                  //Man-made Disaster Button
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context,'/manmadeinfo');
                    },
                    height: 100.r,
                    minWidth: 135.r,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.r))
                    ),
                    color: const Color(0xFFF2F2F2),
                    splashColor: const Color(0x80FEAE49),
                    elevation: 3,
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.white54,
                      child: Image(
                        width: 55.r,
                        image: const AssetImage('assets/images/dashboard/manmade.png')
                      ),
                    )
                  ),
          
                  SizedBox(height: 15.r,),
          
                  Text(
                    languageClass.systemLang["Home"]["ManmadeDis"],
                    style: TextStyle(
                      fontSize: 11.r,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ],
              ),
          
            ],
          )
        ],
      ),
    );
  }
}//Inforgraphic Section



//Utiltity Section
class UtilitySection extends StatelessWidget {
  const UtilitySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Container of Utility Section
    return Container(
      height: 490.r,
      padding: const EdgeInsets.all(10).r,
      margin: const EdgeInsets.fromLTRB(9, 8, 9, 9).r,
      decoration: BoxDecoration(
        color:  const Color(0x4D57BEE6),
        borderRadius: BorderRadius.all(Radius.circular(18.r))
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(9, 6, 9, 15),
            child: Text(
              "Utility",
              style: TextStyle(
                fontSize: 20.r,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.outline, 
              ),
            ),
          ),

          const UtilityButtons()

        ],
      ),
    );
  }
}

