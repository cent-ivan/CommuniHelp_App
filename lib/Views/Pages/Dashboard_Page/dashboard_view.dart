import 'package:communihelp_app/Views/Pages/Dashboard_Page/dashboard_components/dashboard_buttons.dart';
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
          height: 750,
          child:  Column(
            children: <Widget>[

              //ANNOUNCEMENT SECTION
              const AnnouncementSection(),

              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(9, 12, 9, 9),
                child: const Text(
                  "DASHBOARD",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D424A), 
                  ),
                ),
              ),

              //INFOGRAPHICS SECTION
              const InfographicsSection(),

              //UTILITY SECTION
              const UtilitySection()


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
              style: TextStyle(
              fontSize: 25,
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
                      colors: [Color(0xCCFEAE49), Color(0x80FEC57C), Colors.white70, Colors.white60, ], 
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
