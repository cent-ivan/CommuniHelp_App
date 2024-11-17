import 'package:cached_network_image/cached_network_image.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/ViewModel/Connection_Controller/Controller/network_controller.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class ResponderProfileView extends StatefulWidget {
  const ResponderProfileView({super.key});

  @override
  State<ResponderProfileView> createState() => _ResponderProfileViewState();
}

class _ResponderProfileViewState extends State<ResponderProfileView> {
  
  double spaceBetweenDetails = 20.r;
  double spaceBetweenLabel = 2.5.r;
  AssetImage profileImage = const AssetImage('assets/images/rescuer.png');

  final NetworkController network =  Get.put(NetworkController()); //checksconnction

  static final  customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );

  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final responderSettings = UserSettingViewModel();
    responderSettings.loadSettings(curUser!.uid);
    var languageClass = Language(responderSettings.userLanguage);
    
    final viewModel= Provider.of<ProfileViewModel>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 900.r,
            decoration: BoxDecoration(
              image:  DecorationImage(image: Theme.of(context).colorScheme.primary == const Color(0xFFEFEFEF ) ? 
                const AssetImage('assets/images/background/ProfileBackground.png') : const AssetImage('assets/images/background/ProfileDarkBackground.png'), 
              fit: BoxFit.cover),
            
            ),
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 5).r,
            child: Consumer<GetUserData>(builder: (context, userData, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    languageClass.systemLang["Profile"]["ProfileLabel"],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 24.r,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          offset: const Offset(0, 0),
                          blurRadius: 50.r
                        )
                      ]
                    ),
                  ),
                ),

                SizedBox(height: 8.r,),

                //Profile Picture
                Center(
                  child: userData.userProfURL.isNotEmpty ? CachedNetworkImage(
                    cacheManager: customCache,
                    key: UniqueKey(),
                    imageUrl: userData.userProfURL,
                    progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 65.r,
                    )
                  ) 
                  :
                  CircleAvatar(
                    backgroundImage: profileImage,
                    radius: 60.r,
                  ),
                ),

                SizedBox(height: 45.r,),

                //Personal Details
                Column(
                  children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color:  const Color(0x4057BEE6),
                          borderRadius: BorderRadius.all(Radius.circular(10.r))
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                languageClass.systemLang["Profile"]["details"],
                                style: TextStyle(
                                  color: const Color(0xFFFEAE49),
                                  fontSize: 20.r,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                        
                              SizedBox(height: 10.r,),
                        
                              //Details---
                              //FullName
                              Text(
                                languageClass.systemLang["Profile"]["fullname"],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 14.r,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                        
                              SizedBox(height: spaceBetweenLabel,),
                        
                              Text(
                                userData.name,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 18.r,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1
                                ),
                              ),
                            
                        
                              SizedBox(height: spaceBetweenDetails,),
                        
                              //Birthdate
                              Text(
                                languageClass.systemLang["Profile"]["birthday"],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 14.r,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5
                                ),
                              ),
                        
                              SizedBox(height: spaceBetweenLabel,),
                        
                              Text(
                                userData.birthdate,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 18.r,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                        
                        
                              SizedBox(height: spaceBetweenDetails,),
                        
                              //Gender
                              Text(
                                languageClass.systemLang["Profile"]["gender"],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 14.r,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5
                                ),
                              ),
                        
                              SizedBox(height: spaceBetweenLabel,),
                        
                              //Gender display
                              Text(
                                userData.gender,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 18.r,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                        
                        
                              SizedBox(height: spaceBetweenDetails,),
                        
                              //Barangay and Municipality
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Barangay",
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.outline,
                                          fontSize: 14.r,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.5
                                        ),
                                      ),
                        
                                      SizedBox(height: 3.r,),
                        
                                      Text(
                                        userData.barangay,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.outline,
                                          fontSize: 18.r,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                        
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Municipality",
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.outline,
                                          fontSize: 14.r,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.5
                                        ),
                                      ),
                        
                                      SizedBox(height: 3.r,),
                        
                                      Text(
                                        userData.municipality,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.outline,
                                          fontSize: 18.r,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                        
                                  SizedBox(width: 10.r,)
                                ],
                              ),
                                    
                            ],
                          ),
                      
                      ),

                      SizedBox(height: 25.r,),

                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color:  const Color(0x4057BEE6),
                          borderRadius: BorderRadius.all(Radius.circular(10.r))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Contact Number
                            Text(
                              languageClass.systemLang["Profile"]["contactdet"],
                              style: TextStyle(
                                color: const Color(0xFFFEAE49),
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                      
                            SizedBox(height: 10.r,),
                      
                            //Show Email address
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 14.r,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                      
                            SizedBox(height: spaceBetweenLabel,),
                      
                            //Show Email Address
                            Text(
                              userData.email,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 18.r,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1
                              ),
                            ),
                      
                            SizedBox(height: spaceBetweenDetails,),
                      
                      
                            //Show Mobile number
                            Text(
                              "Mobile number",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 14.r,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                      
                            SizedBox(height: spaceBetweenLabel,),
                      
                            Text(
                              userData.mobileNumber,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 18.r,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1
                              ),
                            ),
                      
                            SizedBox(height: 35.r,),
                      
                            //edit button
                            MaterialButton(
                              onPressed: network.isOnline.value ? (){
                                viewModel.loadData(context);
                                Navigator.pushNamed(context, '/editprofile');
                              } : null,
                              height: 50.r,
                              minWidth: 340.r,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.r))
                              ),
                              disabledColor:const Color(0xFFADADAD),
                              color: const Color(0xFFFEC57C),
                              child: Center(
                                child: Text(
                                  languageClass.systemLang["Profile"]["edit"],
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.outline,
                                    fontSize: 14.r,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),

                            Text(
                                network.isOnline.value ? "" : "No internet. Cannot edit",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 10.r,
                                  fontStyle: FontStyle.italic
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                ),
                

              ],
            )
          )
          ),

        ),
      ),
    );
  }
}