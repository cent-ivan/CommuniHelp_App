import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/anouncement_view_model.dart';
import 'package:communihelp_app/ViewModel/Notification_Controller/notification_controller.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/responder_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

//-----------------------------------------------------------------------------------------------
//Announcement Section

class ResponderAnnouncement extends StatefulWidget {
  const ResponderAnnouncement({
    super.key,
  });

  @override
  State<ResponderAnnouncement> createState() => _ResponderAnnouncementState();
}

class _ResponderAnnouncementState extends State<ResponderAnnouncement> {
  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<GetUserData>(context);
    final responderSettings = ResponderSettingViewModel();
    responderSettings.loadSettings(curUser!.uid);
    var languageClass = ResLanguage(responderSettings.userLanguage);
    return Consumer<AnnouncementViewModel>(builder: (context, viewModel, child) => Column(
      children: [
    
        //Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(9, 3, 0, 0).r,
              child: Text(
                languageClass.systemLang["Home"]["Announcement"], 
                  style: TextStyle(
                  fontSize: 25.r,
                  fontWeight: FontWeight.bold, 
                  color: Theme.of(context).colorScheme.outline,               
                ),
              ), 
            ),
          ],
        ),
        
        //Announcement Tiles
        SizedBox(
          height: 220,
          width: 500,
          child: userData.municipality.isNotEmpty ?
          StreamBuilder(
            stream: viewModel.getStream(userData.municipality), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
          
              //if empty
              if (!snapshot.hasData) {
                return SizedBox(
                  width: 380.r,
                  height: 150.r,
          
                  child: Center(
                    child: Text(
                      "No Announcements",
                      style: TextStyle(
                        fontSize: 18.r
                      ),
                    ),
                  ),
                );
              }

              if (snapshot.hasData) {
                NotificationController().showNotification(title: "ANNOUNCEMENT ALERT: at ${userData.municipality}"); //Notification
              }
          
              return ExpandableCarousel(
                options: ExpandableCarouselOptions(
                  indicatorMargin: 3.r,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 6),
                  autoPlayAnimationDuration: Duration(seconds: 2, milliseconds: 5),
                  showIndicator: true,
                  slideIndicator: CircularSlideIndicator(),
                  enlargeCenterPage: true,
                ),
                items: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(5).r,
                    child: GestureDetector(
                      onTap: () => showAnnouncement(data),
                      child: Container(
                        width: 300.r,
                        height: 200.r,
                        padding: const EdgeInsets.all(8).r,
                        decoration: BoxDecoration(
                          border: Border.all(color: data["Urgent"] ? Colors.redAccent : Colors.transparent, width: 4),
                          borderRadius: BorderRadius.all(const Radius.circular(9).r),
                          gradient: LinearGradient(
                            colors: data["Urgent"] ? 
                            [const Color(0xCCFEAE49), const Color(0x80FEC57C), Theme.of(context).colorScheme.surface, ]
                            : [const Color(0xFFADADAD), const Color(0x99F5F5F5), Theme.of(context).colorScheme.surface, ], 
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            tileMode: TileMode.decal
                          ),
                        ),
                          
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                width: 155.r,
                                margin: const EdgeInsets.only(bottom: 8).r,
                                padding: EdgeInsets.all(8).r,
                                decoration: BoxDecoration(
                                  color: data["Urgent"] ? Color(0xE6FEAE49) : Colors.black26,
                                  borderRadius: BorderRadius.all(const Radius.circular(5).r)
                                ),
                                child: Text(
                                  data["Urgent"] ? "ANNOUNCEMENT: ${data["Title"]}" : data["Title"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.r,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2, 
                                ),
                              ),
                            ),
          
                            //date
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3).r,
                                  
                              child: Text(
                                  "Date Posted: ${data["Date"]}",
                                  style: TextStyle(
                                  fontSize: 12.r,
                                  color: Color(0xFF3D424A),
                                  
                                ),
                              ),
                            ),
          
                            //level
                            Container(
                              width: 90.r,
                              margin: const EdgeInsets.only(bottom: 8).r, //item.isUrgent! ? Color(0xE6FEAE49) : Colors.black26
                              decoration: BoxDecoration(
                                color: levelColor(data["Level"], data["Municipality"]),
                                borderRadius: BorderRadius.all(const Radius.circular(2).r)
                              ),
                              child: Text(
                                data["Level"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.r
                                ),
                              ),
                            ),
          
                            
                          
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: Text(
                                data["Content"],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 12.r,
                                  color: data["Urgent"]  ? Theme.of(context).colorScheme.outline:Color(0xFF3D424A)
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2, 
                              ),
                            ),
          
                            
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          ) :
          Center(child: CircularProgressIndicator(),),
        )
      ],
      
    )
    );
  }

  Color levelColor(String level, String municipality) {
    Color levelColor;
    if (level.contains(municipality.toUpperCase())) {
      levelColor =  Colors.black26;
    }
    else if (level.contains("AKLAN")) {
      levelColor = Color(0xE6FEAE49);
    }
    else {
      levelColor = Color(0xBF57BEE6);
    }
    return levelColor;
  }


   void showAnnouncement(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          backgroundColor: Color(0xFFF2F2F2),
          content: SizedBox(
            height: data["Content"].length + 275.r,
            child: Padding(
              padding: const EdgeInsets.all(5).r,
              child: Column(
                children: [
                  //enter title
                  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 155.r,
                                padding: EdgeInsets.all(4).r,
                                margin: const EdgeInsets.only(bottom: 14).r,
                                decoration: BoxDecoration(
                                  color: data["Urgent"] ? Color(0xE6FEAE49) : Colors.black26,
                                  borderRadius: BorderRadius.all(const Radius.circular(5).r),
                                  border: Border.all(color: data["Urgent"] ? Colors.redAccent : Colors.transparent, width: 2),
                                ),
                                child: Text(
                                  data["Urgent"] ? "ANNOUNCEMENT: ${data["Title"]}" : data["Title"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.r,
                                    color: Color(0xFF3D424A)
                                  ),
                                ),
                              ),
                            ),

                            //level
                            Center(
                              child: Container(
                                width: 90.r,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4).r,
                                margin: const EdgeInsets.only(bottom: 16).r, //item.isUrgent! ? Color(0xE6FEAE49) : Colors.black26
                                decoration: BoxDecoration(
                                  color: levelColor(data["Level"], data["Municipality"]),
                                  borderRadius: BorderRadius.all(const Radius.circular(2).r),
                                ),
                                child: Text(
                                  data["Level"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.r
                                  ),
                                ),
                              ),
                            ),


                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9).r,
                                  
                                  child: Text(
                                    "Date: ${data["Date"]}",
                                    style: TextStyle(
                                      fontSize: 12.r,
                                      color: Color(0xFF3D424A),
                                    ),
                                  ),
                            ),

                            

                            SizedBox(height: 5.r,),
      
                            Container(
                              width: 250.r,
                              padding: EdgeInsets.all(14).r,
                              decoration: BoxDecoration(
                                color: Color(0xBFDEDEDE),
                                borderRadius: BorderRadius.all(const Radius.circular(5).r),
                              ),
                              child: Text(
                                data["Content"],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14.r,
                                  color: Color(0xFF3D424A)
                                ),
                              ),
                            ),
                          ],
                        ),

                  //close button
                  Container(
                    margin: EdgeInsets.only(top: 25).r,
                    child: MaterialButton(
                      elevation: 0,
                      color: Color(0xFF57BEE6),
                      onPressed:() {Navigator.pop(context);},
                      child: Center(
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: Color(0xFF3D424A)
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}


