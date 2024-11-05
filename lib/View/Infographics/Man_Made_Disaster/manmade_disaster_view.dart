import 'package:communihelp_app/View/Infographics/Man_Made_Disaster/Manmade_Info_Components/manmade_infographic_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManMadeDisasterView extends StatelessWidget {
  const ManMadeDisasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ManMadeAppBar(),

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Theme.of(context).colorScheme.primary ==  Color(0xFFEFEFEF) ? 
              AssetImage('assets/images/background/InfoNatural.jpg') : AssetImage('assets/images/background/InfoNaturalDark.jpg'),
              fit: BoxFit.cover
            ),
          ),
          height: 915.r,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    
                SafeArea(
                  child: Column(
                    children: [
                      ExpandableCarousel(
                        options: ExpandableCarouselOptions(
                          indicatorMargin: 5.r,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 7),
                          autoPlayAnimationDuration: Duration(seconds: 2, milliseconds: 5),
                          showIndicator: true,
                          slideIndicator: CircularSlideIndicator(),
                          enlargeCenterPage: true,
                        ),
                        items: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            height: 175.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image(
                                image: 
                                const AssetImage("assets/images/infographics/Car_Crash.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            height: 180.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image(
                                image: const AssetImage("assets/images/infographics/Burn.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            height: 180.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image(
                                image: const AssetImage("assets/images/infographics/Structure.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            height: 180.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image(
                                image: const AssetImage("assets/images/infographics/Water_Pollu.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ]
                      ),
                  
                                  
                      SizedBox(height: 20.r,),
                                  
                      //Title
                      Text(
                        "Man-made Disaster",
                        style: TextStyle(
                          fontSize: 20.r,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                                  
                      SizedBox(height: 25.r),
                                  
                      //Translate meaning of Natural disaster to Aklanon
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.r),
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary ==  Color(0xFFEFEFEF) ? Color(0xD9F2F2F2) : Color(0xE631373C),
                          borderRadius: BorderRadius.circular(8.r)
                        ),
                        child: Text(
                          "A man-made disaster can strike with devastating consequences, often stemming from human error, negligence, or intentional harm.",
                          style: TextStyle(
                            fontSize: 16.r
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
            
                SizedBox(height: 25.r,),
                    
                //Buttons in types of natural disaster
                Padding(
                  padding: const EdgeInsets.all(10).r,
                  child: const ManmadeInfoButtons(),
                ),
            
              ],
            ),
          ),
        ),

      ),
    );
  }
}



//APP BAR--------------------------------------------------------------------------------------
class ManMadeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ManMadeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
        "Man-made Disasters",
        style: TextStyle(
          color: Theme.of(context).colorScheme.outline,
          fontSize: 20.r,
          fontWeight: FontWeight.bold
        ),
      ),
    
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20.r,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}