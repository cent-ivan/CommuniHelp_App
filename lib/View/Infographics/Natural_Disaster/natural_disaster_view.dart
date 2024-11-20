import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class NaturalDisasterView extends StatefulWidget {
  const NaturalDisasterView({super.key});

  @override
  State<NaturalDisasterView> createState() => _NaturalDisasterViewState();
}

class _NaturalDisasterViewState extends State<NaturalDisasterView> {
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
        backgroundColor: const Color(0x80A4EACD),
        elevation: 1,
        title: Text(
             languageClass.systemLang["NaturalInfo"]["NaturalTitle"],
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
            image: AssetImage('assets/images/background/natural.png'),
            fit: BoxFit.cover
          )
        ),

        child: Consumer<NaturalDisasterViewModel>(builder: (context, viewModel, child) => Stack(
            children: [
              //Typhoon
              Positioned(
                top: 150,
                left: 65,
                child: Column(
                  children: [
                    _circularButton(viewModel, context, settings.userLanguage, Colors.white, "Typhoon", '/typhhon'),
                    SizedBox(height: 4,),
                    Container(
                      padding: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xA63D424A)
                      ),
                      child: Text(
                        languageClass.systemLang["NaturalInfo"]["TyButton"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEDEDED)
                        ),
                      ),
                    )
                  ],
                )
              ),

              //Landslide
              Positioned(
                top: 280,
                right: 60,
                child: Column(
                  children: [
                    _circularButton(viewModel, context, settings.userLanguage,Color(0xFFFEAE49), "Landslide", '/landslide'),
                    SizedBox(height: 4,),
                    Container(
                      padding: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xA63D424A)
                      ),
                      child: Text(
                        languageClass.systemLang["NaturalInfo"]["LandButton"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEDEDED)
                        ),
                      ),
                    )
                  ],
                )
              ),

              //Flood
              Positioned(
                bottom: 80,
                right: 80,
                child: Column(
                  children: [
                    _circularButton(viewModel, context, settings.userLanguage,Color(0xFF01579B), "Flood", '/flood'),
                    SizedBox(height: 4,),
                    Container(
                      padding: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xA63D424A)
                      ),
                      child: Text(
                        languageClass.systemLang["NaturalInfo"]["FloodButton"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEDEDED)
                        ),
                      ),
                    )
                  ],
                )
              ),

              //Earthquake
              Positioned(
                bottom: 250,
                left: 60,
                child: Column(
                  children: [
                    _circularButton(viewModel, context, settings.userLanguage, Color(0xFFCC3636), "Earthquake", '/earthquake'),
                    SizedBox(height: 4,),
                    Container(
                      padding: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xA63D424A)
                      ),
                      child: Text(
                        languageClass.systemLang["NaturalInfo"]["EarthButton"],
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


  SizedBox _circularButton(NaturalDisasterViewModel viewModel, BuildContext context, String language, Color color, String disaster, String path) {
    return SizedBox(
      height: 25,
      width: 25,
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
          side: BorderSide(color: color, width: 4),
        ),
        child: Container()
      ),
    );
  }


  void _startDialog(NaturalDisasterViewModel viewModel, BuildContext context, Color color, String path) {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(viewModel.coverPath!, height: 150, width:  400, fit: BoxFit.fill,),
            ),
            
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.r),
              decoration: BoxDecoration(
                color: Color(0x80EFEFEF),
                borderRadius: BorderRadius.circular(8).r
              ),
              padding: EdgeInsets.all(16).r,
              child: Text(
                languageClass.systemLang["NaturalInfo"][viewModel.disasterDialog],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFF3D424A),
                  height: 1.5
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
                    languageClass.systemLang["NaturalInfo"]["StartButton"],
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