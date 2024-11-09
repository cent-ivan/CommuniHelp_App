import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NaturalInfoButtons extends StatefulWidget {
  const NaturalInfoButtons({
    super.key,
  });

  @override
  State<NaturalInfoButtons> createState() => _NaturalInfoButtonsState();
}

class _NaturalInfoButtonsState extends State<NaturalInfoButtons> {
  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final viewModel =  Provider.of<NaturalDisasterViewModel>(context);
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage == "Akl" ?  "Fil" : settings.userLanguage); //catches aklanon language to replace with filipino
    return Column(
      children: [
        Text(
          languageClass.systemLang["NaturalInfo"]["Types"],
          style: TextStyle(
            fontSize: 20.r,
            fontWeight: FontWeight.bold
          ),
        ),
        
        SizedBox(height: 15.r,),


        //Typhoon Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Typhoon", settings.userLanguage);
            Navigator.pushNamed(context, '/viewinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/Typhoon.png"),
                    height: 40.r,
                  ),
                ),
                
                SizedBox(width: 40.r,),
        
                Text(
                  languageClass.systemLang["NaturalInfo"]["TyButton"],
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
        
        //Flood Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Flood", settings.userLanguage);
            Navigator.pushNamed(context, '/viewinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/Floods.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  languageClass.systemLang["NaturalInfo"][ "FloodButton"],
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
    
        //Landslide Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Landslide", settings.userLanguage);
            Navigator.pushNamed(context, '/viewinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/Landslide.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  languageClass.systemLang["NaturalInfo"]["LandButton"],
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
    
        //Earthquake Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Earthquake", settings.userLanguage);
            Navigator.pushNamed(context, '/viewinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/Earthquake.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  languageClass.systemLang["NaturalInfo"]["EarthButton"],
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