//Utility Buttons
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/emergency_kit_view_model.dart';
import 'package:communihelp_app/ViewModel/News_View_Model/news_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';



class UtilityButtons extends StatelessWidget {
  const UtilityButtons({
    super.key,
  });

  @override
  
  Widget build(BuildContext context) {
    final getService = Provider.of<GetUserData>(context);
    final viewModel = Provider.of<EmergencyKitViewModel>(context);
    final newsViewModel = Provider.of<NewsViewModel>(context);

    //show current user
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);

    return Wrap(
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
                borderRadius: BorderRadius.all(Radius.circular(12.r))
              ),
              color: Theme.of(context).colorScheme.surfaceContainer,
              splashColor: const Color(0x4D57BEE6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 35.r,
                    image: const AssetImage('assets/images/dashboard/searchevac.png')
                  ),
            
                  Center(
                    child: Text(
                    languageClass.systemLang["Home"]["SearchEvac"],
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
            
            //News Button
            MaterialButton(
              onPressed:  () {
                newsViewModel.callInit();
                Navigator.pushNamed(context,'/newsfeed');
              } ,
              height: 80.r,
              minWidth: 95.r,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.r))
              ),
              color: Theme.of(context).colorScheme.surfaceContainer,
              splashColor: const Color(0x4D57BEE6),
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
                borderRadius: BorderRadius.all(Radius.circular(12.r))
              ),
              color: Theme.of(context).colorScheme.surfaceContainer,
              splashColor: const Color(0x4D57BEE6),
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
            
            //Emergency Kit Button
            MaterialButton(
              onPressed: () {
                viewModel.loadData(getService.user!.uid);
                Navigator.pushNamed(context,'/emergencykit');
              },
              height: 80.r,
              minWidth: 95.r,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.r))
              ),
              color: Theme.of(context).colorScheme.surfaceContainer,
              splashColor: const Color(0x4D57BEE6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 35.r,
                    image: const AssetImage('assets/images/dashboard/mykit.png')
                  ),
            
                  Text(
                  languageClass.systemLang["Home"]["Kit"],
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
            borderRadius: BorderRadius.all(Radius.circular(6.r))
          ),
          child: Wrap(
            spacing: 5.r,
            runSpacing: 10.r,
            alignment: WrapAlignment.center,
            children: [

              Center(
                child: Text(
                  languageClass.systemLang["Home"]["ReportLabel"],
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
                  Navigator.pushNamed(context,'/report');
                },
                height: 80.r,
                minWidth: 95.r,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.r))
                ),
                color: Theme.of(context).colorScheme.surfaceContainer,
                splashColor: const Color(0x4D57BEE6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: 35.r,
                      image: const AssetImage('assets/images/dashboard/file.png')
                    ),
              
                    Text(
                    languageClass.systemLang["Home"]["Report"],
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
    );
  }
}//Utiltity Section