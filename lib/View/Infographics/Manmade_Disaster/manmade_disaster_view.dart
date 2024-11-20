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
              //Fire
              Positioned(
                top: 65,
                left: 75,
                child: Column(
                  children: [
                    _circularButton(viewModel, context, settings.userLanguage,  Color(0xFFFEAE49), "Burn", '/fire'),
                    SizedBox(height: 4,),
                    Container(
                      padding: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xA63D424A)
                      ),
                      child: Text(
                        languageClass.systemLang["ManmadeInfo"]["Fire"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEDEDED)
                        ),
                      ),
                    )
                  ],
                )
              ),

              //Accident
              Positioned(
                top: 90,
                right: 80,
                child: Column(
                  children: [
                    _circularButton(viewModel, context, settings.userLanguage,Colors.white, "Vehicular", '/accident'),
                    SizedBox(height: 4,),
                    Container(
                      padding: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xA63D424A)
                      ),
                      child: Text(
                        languageClass.systemLang["ManmadeInfo"]["Accident"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEDEDED)
                        ),
                      ),
                    )
                  ],
                )
              ),

              //Destroyed Structural
              Positioned(
                bottom: 200,
                right: 100,
                child: Column(
                  children: [
                    _circularButton(viewModel, context, settings.userLanguage,Color(0xFFCC3636), "Structural", '/structure'),
                    SizedBox(height: 4,),
                    Container(
                      padding: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xA63D424A)
                      ),
                      child: Text(
                        languageClass.systemLang["ManmadeInfo"]["Failure"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEDEDED)
                        ),
                      ),
                    )
                  ],
                )
              ),

              //Pollution
              Positioned(
                bottom: 65,
                left: 75,
                child: Column(
                  children: [
                    _circularButton(viewModel, context, settings.userLanguage, Color(0xFF01579B), "Pollution", '/pollution'),
                    SizedBox(height: 4,),
                    Container(
                      padding: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xA63D424A)
                      ),
                      child: Text(
                        languageClass.systemLang["ManmadeInfo"]["Pollution"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEDEDED)
                        ),
                      ),
                    )
                  ],
                )
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
          logger.e("Language: $language");
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
          contentPadding: EdgeInsets.all(16).r,
          children: [
            Image.asset(viewModel.coverPath!, height: 180, width:  400, fit: BoxFit.fill,),
            SizedBox(height: 8.r,),


            Container(
              margin: EdgeInsets.symmetric(vertical: 4.r),
              decoration: BoxDecoration(
                color: Color(0x80EFEFEF),
                borderRadius: BorderRadius.circular(8).r
              ),
              padding: EdgeInsets.all(8).r,
              child: Text(
                languageClass.systemLang["ManmadeInfo"][viewModel.disasterDialog],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFF3D424A),
                  height: 2
                ),
              ),
            ),

            //redirect to pages
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