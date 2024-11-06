import 'package:communihelp_app/ViewModel/Home_View_Models/anouncement_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../Model/announcement_model.dart';
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
    return Consumer<AnnouncementViewModel>(builder: (context, viewModel, child) => Column(
      children: [
    
        //Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(9, 3, 0, 0).r,
              child: TextButton(
                onPressed: () {
                  viewModel.loadAnnouncement();
                },
                child: Text(
                  "Announcement", 
                    style: TextStyle(
                    fontSize: 25.r,
                    fontWeight: FontWeight.bold, 
                    color: Theme.of(context).colorScheme.outline,               
                  ),
                ),
              ), 
            ),

            IconButton(
              onPressed: () {
                setState(() {
                  viewModel.loadAnnouncement();
                });   
                }, 
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.outline,
              )
            )
          ],
        ),
        
        //Announcement Tiles
        viewModel.dbAnnouncement.announcements.isNotEmpty ?
        SizedBox(
          width: 380.r,
          height: 200.r,
          child: SafeArea(
            child: ExpandableCarousel(
              options: ExpandableCarouselOptions(
                indicatorMargin: 3.r,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 6),
                autoPlayAnimationDuration: Duration(seconds: 2, milliseconds: 5),
                showIndicator: true,
                slideIndicator: CircularSlideIndicator(),
                enlargeCenterPage: true,
              ),
              items: viewModel.dbAnnouncement.announcements.map((item) { //creates a Iterable to loop list
                  return Padding(
                    padding: const EdgeInsets.all(5).r,
                    child: GestureDetector(
                      onTap: () => showAnnouncement(item),
                      child: Container(
                        width: 300.r,
                        height: 200.r,
                        padding: const EdgeInsets.all(8).r,
                        decoration: BoxDecoration(
                          border: Border.all(color: item.isUrgent! ? Colors.redAccent : Colors.transparent, width: 4),
                          borderRadius: BorderRadius.all(const Radius.circular(9).r),
                          gradient: LinearGradient(
                            colors: item.isUrgent! ? 
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
                                decoration: BoxDecoration(
                                  color: item.isUrgent! ? Color(0xE6FEAE49) : Colors.black26,
                                  borderRadius: BorderRadius.all(const Radius.circular(5).r)
                                ),
                                child: Text(
                                  item.isUrgent! ? "ANNOUNCEMENT: ${item.title!}" : item.title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.r
                                  ),
                                ),
                              ),
                            ),

                            //date
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3).r,
                                  
                              child: Text(
                                  "Date Posted: ${item.date}",
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
                                color: levelColor(item.level!, item.municipality!),
                                borderRadius: BorderRadius.all(const Radius.circular(2).r)
                              ),
                              child: Text(
                                item.level!,
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
                                item.content!,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 12.r,
                                  color: item.isUrgent! ? Theme.of(context).colorScheme.outline:Color(0xFF3D424A)
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3, 
                              ),
                            ),

                            
                          ],
                        ),
                      ),
                    ),
                  );
    
                }).toList(), // Convert the list of items into widgets
              )
            )
          
        )
        :
        //shows if emmpty
        SizedBox(
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


  void showAnnouncement(AnnouncementModel item) {
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
            height: item.content!.length + 255.r,
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
                                  color: item.isUrgent! ? Color(0xE6FEAE49) : Colors.black26,
                                  borderRadius: BorderRadius.all(const Radius.circular(5).r),
                                  border: Border.all(color: item.isUrgent! ? Colors.redAccent : Colors.transparent, width: 2),
                                ),
                                child: Text(
                                  item.isUrgent! ? "ANNOUNCEMENT: ${item.title!}" : item.title!,
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
                                  color: levelColor(item.level!, item.municipality!),
                                  borderRadius: BorderRadius.all(const Radius.circular(2).r),
                                ),
                                child: Text(
                                  item.level!,
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
                                    "Date: ${item.date}",
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
                                item.content!,
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


