import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,//const Color(0xFFE0E0E0),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(13),
          height: 1000,
          child: const Column(
            children: <Widget>[

              //ANNOUNCEMENT SECTION
              AnnouncementSection(),

              //DASHBOARD SECTION



            ],
          )
        ),
      ),
    );
  }
}




//-----------------------------------------------------------------------------------------------
//Announcement Section
class AnnouncementSection extends StatefulWidget {
  const AnnouncementSection({
    super.key,
  });

  @override
  State<AnnouncementSection> createState() => _AnnouncementSectionState();
}

class _AnnouncementSectionState extends State<AnnouncementSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    
        //Title
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.fromLTRB(9, 3, 9, 0),
          child: const Text(
            "Announcement", 
            style: TextStyle(fontSize: 25,
            fontWeight: FontWeight.bold, 
            color: Color(0xFF3D424A),               
            ),
          ), 
        ),
        
        //Announcement Tiles
        SizedBox(
          width: 350,
          height: 150,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 280,
                  height: 160,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    gradient: LinearGradient(
                      colors: [Color(0xFF858480), Color(0xFFE6E5DE), Colors.white38, Colors.white30, ], 
                      //stops: [0.0001,0.45],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.decal
                    )
                  ),
                ),
              );
            }
          ),
        ),
      ],
      
    );
  }
}