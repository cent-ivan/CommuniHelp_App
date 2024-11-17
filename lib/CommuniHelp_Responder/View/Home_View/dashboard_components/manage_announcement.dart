import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_announcement.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/anouncement_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ManageAnnouncement extends StatefulWidget {
  const ManageAnnouncement({super.key});

  @override
  State<ManageAnnouncement> createState() => _ManageAnnouncementState();
}

class _ManageAnnouncementState extends State<ManageAnnouncement> {
  //Firestore instance
  final _db = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<GetUserData>(context);
    final getAnnouncement = Provider.of<GetAnnouncement>(context);
    
    return Scaffold(
      appBar: AnnouncementAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8).r,
        child: StreamBuilder(stream: _db.collection('announcements').doc(userData.municipality.toUpperCase()).collection("${userData.municipality.toUpperCase()}_announcement").snapshots(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text("No Announcements"),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return data.isEmpty ?
                Center(
                  child: Text("No Announcements"),
                ) :
                GestureDetector(
                  onTap: () {
                    showAnnouncement(data);
                  },
                  child: Container(
                    height: 80.r,
                    padding: EdgeInsets.all(8).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: data["Urgent"] ? Color(0xFFFE9F49) : Theme.of(context).colorScheme.primary,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Announcement info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              elipseText(data["Title"], 25),
                              style: TextStyle(
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                  
                            Text(
                              "Date posted: ${data["Date"]}",
                              style: TextStyle(
                                fontSize: 12.r,
                                color: Theme.of(context).colorScheme.outline
                              ),
                            ),

                            Text(
                              "Level: ${data["Level"]}",
                              style: TextStyle(
                                fontSize: 12.r,
                                color: Theme.of(context).colorScheme.outline
                              ),
                            ),

                          ],
                        ),

                        //remove button
                        MaterialButton(
                          minWidth: 10.r,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.r),)
                          ),
                          onPressed: () {
                            getAnnouncement.deleteAnnouncement(document.id, data["Municipality"]);
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/dashboard/remove.png'),
                            radius: 20.r,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
        ),
      ),

      floatingActionButton: SizedBox.fromSize(
        size: Size.square(65.r),
        child: FloatingActionButton(
          elevation: 0,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/postannouncement');
          },
          backgroundColor: const Color(0xFFFEAE49),
          foregroundColor: Colors.white,
          splashColor: Colors.redAccent,
          child: Icon(
            Icons.add,
            size: 30.r,
          ),
        ),
      ),
    );
  }

  //for overflowing text
  String elipseText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  //for level color tags
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
                                  data["Urgent"] ? "ANNOUNCEMENT:  ${data["Title"]}" : data["Title"],
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
                                margin: const EdgeInsets.only(bottom: 12).r, //item.isUrgent! ? Color(0xE6FEAE49) : Colors.black26
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
                                      fontSize: 13.r,
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

//APP BAR----------------------------------------------------------------------------------------------------
class AnnouncementAppBar extends StatelessWidget implements PreferredSizeWidget{
  const AnnouncementAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AnnouncementViewModel>(context);

    User? curUser = FirebaseAuth.instance.currentUser;
    final responderSettings = UserSettingViewModel();
    responderSettings.loadSettings(curUser!.uid);
    var languageClass = Language(responderSettings.userLanguage);
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),
          
        child: Text(
          languageClass.systemLang["MakeAnnounce"]["AnnounceTitle"],
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
          
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20,
        onPressed: () {
          Navigator.pop(context);
          viewModel.loadAnnouncement();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}



