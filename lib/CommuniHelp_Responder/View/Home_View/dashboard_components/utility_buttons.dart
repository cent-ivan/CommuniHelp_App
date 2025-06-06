//Utility Buttons
import 'package:communihelp_app/ViewModel/News_View_Model/news_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';



class ResponderUtilityButtons extends StatefulWidget {
  const ResponderUtilityButtons({
    super.key,
  });

  @override
  State<ResponderUtilityButtons> createState() => _ResponderUtilityButtonsState();
}

class _ResponderUtilityButtonsState extends State<ResponderUtilityButtons> {
  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  
  @override
  Widget build(BuildContext context) {
    //final getService = Provider.of<GetUserData>(context);
    final responderSettings = UserSettingViewModel();
    responderSettings.loadSettings(curUser!.uid);
    var languageClass = Language(responderSettings.userLanguage);

    final newsViewModel = Provider.of<NewsViewModel>(context);

    return Container(
      padding: EdgeInsets.all(10).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9).r),
        color: const Color(0xB3FEAE49)
      ),
      child: Wrap(
        spacing: 5.r,
        runSpacing: 10.r,
        alignment: WrapAlignment.center,
        children: [
          //----------------------------------------------------------------------------------------------------------
              
          Wrap(
            spacing: 5.r,
            runSpacing: 10.r,
            alignment: WrapAlignment.center,
            children: [
              //Evacuation Button
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context,'/evacuationfinder');
                },
                height: 80.r,
                minWidth: 100.r,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.r))
                ),
                color: Color(0xFFF2F2F2),
                splashColor: const Color(0xFFFEAE49),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: 35.r,
                      image: const AssetImage('assets/images/dashboard/searchevac.png')
                    ),
              
                    Center(
                      child: Text(
                      languageClass.systemLang["Home"]["MarkEvac"],
                          style: TextStyle(
                          fontSize: 12.r,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3D424A), 
                        ),
                      ),
                    ),
                  ],
                )
              ),


              //Post Announcement
              MaterialButton(
                onPressed: () {
      
                  Navigator.pushNamed(context, '/manageannouncement');
                },
                height: 80.r,
                minWidth: 95.r,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.r))
                ),
                color: Color(0xFFF2F2F2),
                splashColor: const Color(0xFFFEAE49),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: 33.r,
                      image: const AssetImage('assets/images/dashboard/announcementicon.png')
                    ),
              
                    Text(
                    languageClass.systemLang["Home"]["PostAnnounce"],
                        style: TextStyle(
                        fontSize: 11.r,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3D424A), 
                      ),
                    ),
                  ],
                )
              ),
              
              //News Button
              MaterialButton(
                onPressed: () {
                  newsViewModel.callInit();
                  Navigator.pushNamed(context,'/newsfeed');
                },
                height: 80.r,
                minWidth: 95.r,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.r))
                ),
                color: Color(0xFFF2F2F2),
                splashColor: const Color(0xFFFEAE49),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: 35.r,
                      image: const AssetImage('assets/images/dashboard/newspaper.png')
                    ),
              
                    Text(
                    languageClass.systemLang["Home"]["News"],
                        style: TextStyle(
                        fontSize: 12.r,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3D424A), 
                      ),
                    ),
                  ],
                )
              ),
      
              //Weather Button  
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context,'/weatherupdate');
                },
                height: 80.r,
                minWidth: 95.r,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.r))
                ),
                color: Color(0xFFF2F2F2),
                splashColor: const Color(0xFFFEAE49),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: 35.r,
                      image: const AssetImage('assets/images/dashboard/weather.png')
                    ),
              
                    Text(
                    languageClass.systemLang["Home"]["Weather"],
                        style: TextStyle(
                        fontSize: 12.r,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3D424A), 
                      ),
                    ),
                  ],
                )
              ),
        
          
            ],
          ),
      
          //----------------------------------------------------------------------------------------------------------
          Container(
            margin: const EdgeInsets.only(top: 15).r,
            padding: const EdgeInsets.fromLTRB(10,10,10,15).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(9.r))
            ),
            child: Wrap(
              spacing: 5.r,
              runSpacing: 10.r,
              alignment: WrapAlignment.center,
              children: [
      
                Center(
                  child: Text(
                    languageClass.systemLang["Home"]["ReportResp"],
                        style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline, 
                      ),
                  ),
                ),
                
                //Report Button
                MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context,'/viewreport');
                  },
                  height: 80.r,
                  minWidth: 95.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.r))
                  ),
                  color: Color(0xFFF2F2F2),
                  splashColor: const Color(0xFFFEAE49),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        width: 35.r,
                        image: const AssetImage('assets/images/dashboard/file.png')
                      ),
                
                      Text(
                      languageClass.systemLang["Home"]["ReportRespButton"],
                          style: TextStyle(
                          fontSize: 11.r,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3D424A), 
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
      
        ],
      ),
    );
  }
}//Utiltity Section