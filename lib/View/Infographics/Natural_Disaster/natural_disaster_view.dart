import 'package:communihelp_app/View/Infographics/Natural_Disaster/Natural_Info_Components/natural_infographic_buttons.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NaturalDisasterView extends StatefulWidget {
  const NaturalDisasterView({super.key});

  @override
  State<NaturalDisasterView> createState() => _NaturalDisasterViewState();
}

class _NaturalDisasterViewState extends State<NaturalDisasterView> {
  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage == "Akl" ?  "Fil" : settings.userLanguage); //catches aklanon language to replace with filipino
    return Scaffold(
      appBar: const NaturalAppBar(),

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Theme.of(context).colorScheme.primary ==  Color(0xFFEFEFEF) ? 
              AssetImage('assets/images/background/InfoNatural.jpg') : AssetImage('assets/images/background/InfoNaturalDark.jpg'),
              fit: BoxFit.cover
            ),
          ),
          height: 980.r,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    
                SafeArea(
                  child: Column(
                    children: [
                      ExpandableCarousel(
                        options: ExpandableCarouselOptions(
                          indicatorMargin: 5.r,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 7),
                          autoPlayAnimationDuration: Duration(seconds: 2, milliseconds: 5),
                          showIndicator: true,
                          slideIndicator: CircularSlideIndicator(),
                          enlargeCenterPage: true,
                        ),
                        items: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            height: 180.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image(
                                image: 
                                
                                const AssetImage("assets/images/infographics/Typhoon.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            height: 180.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image(
                                image: const AssetImage("assets/images/infographics/Flood.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            height: 180.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image(
                                image: const AssetImage("assets/images/infographics/Landslide.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            height: 180.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image(
                                image: const AssetImage("assets/images/infographics/Earthq.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ]
                      ),
                  
                                  
                      SizedBox(height: 20.r,),
                                  
                      //Title
                      Text(
                        languageClass.systemLang["NaturalInfo"]["NaturalTitle"],
                        style: TextStyle(
                          fontSize: 20.r,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                                  
                      SizedBox(height: 25.r),
                                  
                      //Translate meaning of Natural disaster to Aklanon
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.r),
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary ==  Color(0xFFEFEFEF) ? Color(0xD9F2F2F2) : Color(0xE631373C),
                          borderRadius: BorderRadius.circular(8.r)
                        ),
                        child: Text(
                          languageClass.systemLang["NaturalInfo"]["Definition"],
                          style: TextStyle(
                            fontSize: 16.r
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
            
                SizedBox(height: 25.r,),
                    
                //Buttons in types of natural disaster
                Padding(
                  padding: const EdgeInsets.all(10).r,
                  child: const NaturalInfoButtons(),
                ),
            
              ],
            ),
          ),
        ),

      ),
    );
  }
}



//APP BAR--------------------------------------------------------------------------------------
class NaturalAppBar extends StatelessWidget implements PreferredSizeWidget{
  const NaturalAppBar({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {
    //show current user
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage == "Akl" ?  "Fil" : settings.userLanguage); //catches aklanon language to replace with filipino
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
        languageClass.systemLang["NaturalInfo"]["NaturalTitle"],
        style: TextStyle(
          color: Theme.of(context).colorScheme.outline,
          fontSize: 20.r,
          fontWeight: FontWeight.bold
        ),
      ),
    
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20.r,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}