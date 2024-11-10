import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../ViewModel/Inforgraphics_Controller/manmade_dis_view_model.dart';

class ManmadeInfoButtons extends StatefulWidget {
  const ManmadeInfoButtons({
    super.key,
  });

  @override
  State<ManmadeInfoButtons> createState() => _ManmadeInfoButtonsState();
}

class _ManmadeInfoButtonsState extends State<ManmadeInfoButtons> {
  User? curUser = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    final viewModel =  Provider.of<ManMadeDisasterViewModel>(context);
    final settings = Provider.of<UserSettingViewModel>(context);
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage == "Akl" ?  "Fil" : settings.userLanguage); //catches aklanon language to replace with filipino
    return Column(
      children: [
        Text(
          languageClass.systemLang["ManmadeInfo"]["Types"],
          style: TextStyle(
            fontSize: 20.r,
            fontWeight: FontWeight.bold
          ),
        ),
        
        SizedBox(height: 15.r,),


        //Vehicular Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Vehicular", settings.userLanguage == "Akl" ?  "Fil" : settings.userLanguage);
            Navigator.pushNamed(context, '/viewmanmadeinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/auto_accident.png"),
                    height: 40.r,
                  ),
                ),
                
                SizedBox(width: 40.r,),
        
                Text(
                  languageClass.systemLang["ManmadeInfo"]["Accident"],
                  style: TextStyle(
                    fontSize: 18.r,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),

        SizedBox(height: 10.r,),
        
        //Burn Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Burn",settings.userLanguage == "Akl" ?  "Fil" : settings.userLanguage);
            Navigator.pushNamed(context, '/viewmanmadeinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/burn.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  languageClass.systemLang["ManmadeInfo"]["Fire"],
                  style: TextStyle(
                    fontSize: 18.r,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
    
        SizedBox(height: 10.r,),
    
        //Structural Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Structural",settings.userLanguage == "Akl" ?  "Fil" : settings.userLanguage);
            Navigator.pushNamed(context, '/viewmanmadeinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/ruined.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  languageClass.systemLang["ManmadeInfo"]["Failure"],
                  style: TextStyle(
                    fontSize: 16.r,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
    
        SizedBox(height: 10.r,),
    
        //Pollution Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Pollution", settings.userLanguage == "Akl" ?  "Fil" : settings.userLanguage);
            Navigator.pushNamed(context, '/viewmanmadeinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/ocean.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  languageClass.systemLang["ManmadeInfo"]["Pollution"],
                  style: TextStyle(
                    fontSize: 18.r,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),

        SizedBox(height: 10.r,),
    
      ],
    );
  }
}