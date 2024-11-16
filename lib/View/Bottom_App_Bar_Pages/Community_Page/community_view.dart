import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Community_Page/post_dialog.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/community_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import '../../../ViewModel/Connection_Controller/Controller/network_controller.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {

  final dialog = PostDialog();

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
    final userData = Provider.of<GetUserData>(context, listen: false);
    final viewModel = Provider.of<CommunityViewModel>(context);

    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage); //catches aklanon language to replace with filipino
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: const PageStorageKey<String>('CommunityView'),

        backgroundColor: Theme.of(context).colorScheme.surface,

        body: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              GestureDetector(
                //add post add post dialog
                onTap: () {
                  network.isOnline.value ? 
                  dialog.addPost(context) : null;
                },
                child: Container(
                  height: 50.r,
                  padding: EdgeInsets.only(left: 25.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: network.isOnline.value ?  Theme.of(context).colorScheme.primary : Colors.grey.shade700,
                  ),
                
                  child: Row(
                    children: [
                      Icon(
                        Icons.post_add_rounded,
                        size: 30.r,
                        color: network.isOnline.value ?  Theme.of(context).colorScheme.outline : Colors.grey.shade900 ,
                      ),
                
                      Text(
                        network.isOnline.value ? languageClass.systemLang["Forum"]["PostButton"] : languageClass.systemLang["Forum"]["Offline"],
                        style: TextStyle(
                          color:  network.isOnline.value ? Theme.of(context).colorScheme.outline: Colors.grey.shade800 ,
                          fontSize: 16.r,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10.r,),

              //StreamBuilder
              Expanded(
                child: StreamBuilder(
                  stream: viewModel.getStream(userData.municipality), //get posts by municipality
                  builder: (context, snapshot) {
                     

                    //produce a list of widgets
                    return ListView(
                      children: snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
                      
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      List<Map<String,bool>> collectionLikes = (data["Presses"] as List).map((item) => Map<String, bool>.from(item as Map)).toList();
                      viewModel.loadStatus(userData, collectionLikes);
                        return Container(
                          height: ((data["Title"].length - 10) + (data["Content"].length - 18) + 290.r), //Height
                          padding: EdgeInsets.only(left: 15, top: 20).r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: data["Type"] == "user" ? Theme.of(context).colorScheme.primary : Color(0xFFFE9F49),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 15).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //Poster details
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8).r,
                                    //for getting profile
                                    child: data["Profile"] != null ? 
                                    //if had picture
                                    CachedNetworkImage(
                                      cacheManager: customCache,
                                      key: UniqueKey(),
                                      imageUrl: data["Profile"],
                                      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) => CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/user.png') ,
                                        radius: 20.r,
                                      ),
                                      imageBuilder: (context, imageProvider) => CircleAvatar(
                                        backgroundImage: imageProvider,
                                        radius: 25.r,
                                      )
                                    ) 
                                    : CircleAvatar(
                                      radius: 25.r,
                                      backgroundColor: Colors.black,
                                    ),
                                  ),

                                  SizedBox(width: 12.r,),
                                        
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data["Name"]}, ${languageClass.systemLang["Forum"]["from"]}${data["Barangay"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.r
                                        ),
                                      ),

                                      Text(
                                        data["Type"].contains("responder") ? "Responder" : ""
                                      ),

                                      Text(
                                        data["Date"]
                                      )

                                    ],
                                  ),

          
                                ],
                              ),

                              //Title
                              Padding(
                                padding: const EdgeInsets.only(top: 8, right: 18).r,
                                child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 10.r),
                                      child: Text(
                                        data["Title"],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 16.r,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                ),
                              ),

                              //Content
                              Padding(
                                padding: const EdgeInsets.only(top: 7, bottom: 15, right: 18).r,
                                child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 10.r),
                                      child: Text(
                                        data["Content"],
                                        textAlign: TextAlign.justify,
                                      ),
                                ),
                              ),

                              Divider(),

                              //Likes
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5).r,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_circle_up_outlined),
                                      color: viewModel.isPressed! ? Color(0xFF57E2E6) : Theme.of(context).colorScheme.outline,
                                      disabledColor: Colors.grey.shade800,
                                      iconSize: 24.r,
                                      onPressed: () {
                                        network.isOnline.value ? 
                                        viewModel.checkUser(document.id, userData, data["Likes"], collectionLikes) : null;
                                      }
                                    )
                                  ),

                                  Text(
                                    data["Likes"].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.r
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                          ,
                        );
                      }).toList(),
                    );
                  }
                ),
              )


            ],
          ),

        ),
      ),
    );
  }
}