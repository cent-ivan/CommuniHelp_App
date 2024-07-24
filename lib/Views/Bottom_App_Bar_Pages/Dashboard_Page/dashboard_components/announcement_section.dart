import 'package:communihelp_app/ViewModels/anouncement_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
          margin: const EdgeInsets.fromLTRB(9, 3, 9, 0).r,
          child: Text(
            "Announcement", 
              style: TextStyle(
              fontSize: 25.r,
              fontWeight: FontWeight.bold, 
              color: Theme.of(context).colorScheme.outline,               
            ),
          ), 
        ),
        
        //Announcement Tiles
        SizedBox(
          width: 350.r,
          height: 150.r,
          child: Consumer<AnnouncementViewModel>(builder: (context, viewModel, child) => ListView.builder(
              itemCount: viewModel.announcements.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8).r,
                  child: Container(
                    width: 280.r,
                    height: 160.r,
                    padding: const EdgeInsets.all(8).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(const Radius.circular(9).r),
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
                          width: 155.r,
                          margin: const EdgeInsets.only(bottom: 8).r,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(const Radius.circular(5).r)
                          ),
                          child: Text(
                            viewModel.announcements[index].title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.r
                            ),
                          ),
                        ),

                        Text(
                          viewModel.announcements[index].content!,
                          style: TextStyle(
                            fontSize: 11.r
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        ),
      ],
      
    );
  }
}