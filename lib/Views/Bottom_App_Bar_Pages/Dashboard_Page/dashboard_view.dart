import 'package:communihelp_app/Views/Bottom_App_Bar_Pages/Dashboard_Page/dashboard_components/dashboard_buttons.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,//if dark mode const Color(0xFF3D424A)
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(9, 20, 9, 0),
          height: 1075,
          child:  Column(
            children: <Widget>[

              //ANNOUNCEMENT SECTION
              const AnnouncementSection(),

              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(9, 28, 9, 9),
                child: Text(
                  "DASHBOARD",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline, 
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
  final int numOfAnnouncement = 1; //get total announcement in database

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    
        //Title
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.fromLTRB(9, 3, 9, 0),
          child: Text(
            "Announcement", 
              style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold, 
              color: Theme.of(context).colorScheme.outline,               
            ),
          ), 
        ),
        
        //Announcement Tiles
        SizedBox(
          width: 350,
          height: 150,
          child: ListView.builder(
            itemCount: numOfAnnouncement,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 280,
                  height: 160,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    gradient: LinearGradient(
                      colors: [const Color(0xCCFEAE49), const Color(0x80FEC57C), Theme.of(context).colorScheme.surface, ], 
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.decal
                    ),
                  ),

                  //TODO: Change dummy text
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 155,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: const Text(
                          "Nabas Announcement",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec imperdiet sit amet leo sed tempor."
                      ),
                    ],
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
