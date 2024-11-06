import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_announcement.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/anouncement_view_model.dart';
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
                child: Text("Walang laman. Umpisahan"),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return GestureDetector(
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

  String elipseText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
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
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),
          
        child: const Text(
          "Make Announcement",
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



