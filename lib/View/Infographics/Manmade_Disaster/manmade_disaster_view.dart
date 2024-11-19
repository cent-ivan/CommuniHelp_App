import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/manmade_dis_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ManmadeDisasterView extends StatefulWidget {
  const ManmadeDisasterView({super.key});

  @override
  State<ManmadeDisasterView> createState() => _ManmadeDisasterViewState();
}

class _ManmadeDisasterViewState extends State<ManmadeDisasterView> {
  Logger logger = Logger();

  //show current user
   User? curUser = FirebaseAuth.instance.currentUser;
  final settings = UserSettingViewModel();
    
  
  @override
  Widget build(BuildContext context) {
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
        title: Text(
             languageClass.systemLang["ManmadeInfo"]["Title"],
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
            
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/weather_back.png'),
            fit: BoxFit.cover
          )
        ),

        child: Consumer<ManMadeDisasterViewModel>(builder: (context, viewModel, child) => Stack(
            children: [
              //Typhoon
              Positioned(
                top: 65,
                left: 75,
                child: _circularButton(viewModel, context, settings.userLanguage, Colors.white, "Burn", '/fire')
              ),

              //Landslide
              Positioned(
                top: 90,
                right: 80,
                child: _circularButton(viewModel, context, settings.userLanguage,Color(0xFFFEAE49), "Vehicular", '/accident')
              ),

              //Flood
              Positioned(
                bottom: 90,
                right: 100,
                child: _circularButton(viewModel, context, settings.userLanguage,Color(0xFF01579B), "Structural", '/structure')
              ),

              //Earthquake
              Positioned(
                bottom: 65,
                left: 75,
                child: _circularButton(viewModel, context, settings.userLanguage,Colors.brown, "Pollution", '/pollution')
              ),

            ],
          ),
        ),
      )
    );
  }


  SizedBox _circularButton(ManMadeDisasterViewModel viewModel, BuildContext context, String language, Color color, String disaster, String path) {
    return SizedBox(
      height: 20,
      width: 20,
      child: ElevatedButton(
        onPressed: () {
          logger.d("Language: $language");
          viewModel.getPath(disaster, language);
          _startDialog(viewModel , context, color, path);
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(12).r,
          elevation: 3,
          backgroundColor: Colors.transparent,
          side: BorderSide(color: color, width: 2),
        ),
        child: Container()
      ),
    );
  }


  void _startDialog(ManMadeDisasterViewModel viewModel, BuildContext context, Color color, String path) {
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);

    showDialog(
      context: context, 
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Color(0xA6EFEFEF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r))
          ),
          titlePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0).r,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8).r,
          children: [
            Image.asset(viewModel.coverPath!, height: 200, width:  350),
            SizedBox(height: 8.r,),


            Padding(
              padding: EdgeInsets.all(12).r,
              child: Row(
                children: [
                  Container()
                ],
              ),
            ),

            MaterialButton(
              color: Color(0xFF57BEE6),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r))
              ),
              onPressed: () {
                Navigator.pushNamed(context, path);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    languageClass.systemLang["ManmadeInfo"]["StartButton"],
                    style: TextStyle(color: Color(0xFF3D424A) ,), 
                  ),
                  
                  Icon(Icons.arrow_right_alt, size: 35, color: Color(0xFF3D424A),)
                ],
              )
            )
          ],
        );
      }
    );
  }

}