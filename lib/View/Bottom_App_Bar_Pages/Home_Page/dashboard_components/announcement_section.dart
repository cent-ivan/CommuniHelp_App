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
                  viewModel.addAnnouncement();
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
                  viewModel.addAnnouncement();
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
          height: 180.r,
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
                        height: 180.r,
                        padding: const EdgeInsets.all(8).r,
                        decoration: BoxDecoration(
                          border: Border.all(color: item.isUrgent! ? Colors.redAccent : Colors.transparent, width: 2),
                          borderRadius: BorderRadius.all(const Radius.circular(9).r),
                          gradient: LinearGradient(
                            colors: item.isUrgent! ? 
                            [const Color(0xCCFEAE49), const Color(0x80FEC57C), Theme.of(context).colorScheme.surface, ]
                            : [const Color(0xD9F3F3F3), const Color(0x99F5F5F5), Theme.of(context).colorScheme.surface, ], 
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            tileMode: TileMode.decal
                          ),
                        ),
                          
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 155.r,
                              margin: const EdgeInsets.only(bottom: 8).r,
                              decoration: BoxDecoration(
                                color: item.isUrgent! ? Color(0xE6FEAE49) : Colors.black26,
                                borderRadius: BorderRadius.all(const Radius.circular(5).r)
                              ),
                              child: Text(
                                item.isUrgent! ? "Urgent: ${item.title!}" : item.title!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.r
                                ),
                              ),
                            ),
                          
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: Text(
                                item.content!,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 11.r
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 6, 
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


  void showAnnouncement(AnnouncementModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          content: SizedBox(
            height: item.content!.length + 165.r,
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
                                margin: const EdgeInsets.only(bottom: 20).r,
                                decoration: BoxDecoration(
                                  color: item.isUrgent! ? Color(0xE6FEAE49) : Colors.black26,
                                  borderRadius: BorderRadius.all(const Radius.circular(5).r)
                                ),
                                child: Text(
                                  item.isUrgent! ? "Urgent: ${item.title!}" : item.title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.r
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9).r,
                                  
                                  child: Text(
                                    "Date: ${item.date!.day}/${item.date!.month}/${item.date!.year}",
                                    style: TextStyle(
                                      fontSize: 12.r,
                                      letterSpacing: 2,
                                      decoration: TextDecoration.underline ,
                                    ),
                                  ),
                            ),
      
                            Padding(
                              padding: const EdgeInsets.all(8).r,
                              child: Text(
                                item.content!,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14.r
                                ),
                              ),
                            ),
                          ],
                        ),

                  Container(
                    margin: EdgeInsets.only(top: 25).r,
                    child: MaterialButton(
                      elevation: 0,
                      color: Color(0xE6F5F5F5),
                      onPressed:() {Navigator.pop(context);},
                      child: Center(
                        child: Text("Close"),
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


