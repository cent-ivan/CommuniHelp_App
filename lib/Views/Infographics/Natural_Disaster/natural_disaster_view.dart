import 'package:communihelp_app/Views/Infographics/Natural_Disaster/Natural_Info_Components/natural_infographic_buttons..dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NaturalDisasterView extends StatelessWidget {
  const NaturalDisasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const NaturalAppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10).r,
          child: SizedBox(
            height: MediaQuery.of(context).size.height + 200.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  children: [
                    //Slider Image (Not yet done)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image(
                          image: const AssetImage("assets/images/infographics/Typhoon.jpg"),
                          height: 200.r,
                        ),
                      ),
                    ),
                                
                    SizedBox(height: 15.r,),
                                
                    //Title
                    Text(
                      "Natural na Sakuna",
                      style: TextStyle(
                        fontSize: 20.r,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                                
                    SizedBox(height: 25.r),
                                
                    //Translate meaning of Natural disaster to Aklanon
                    Text(
                      "Natural disasters, such as hurricanes, earthquakes, floods, wildfires, and tsunamis, can cause widespread devastation and loss of life. These events are often unpredictable and can occur suddenly, leaving communities with little time to prepare.",
                      style: TextStyle(
                        fontSize: 14.r
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
            
                SizedBox(height: 25.r,),

                //Buttons in types of natural disaster
                const NaturalInfoButtons(),
            
              ],
            ),
          ),
        ),

      ),
    );
  }
}



//APP BAR--------------------------------------------------------------------------------------
class NaturalAppBar extends StatelessWidget implements PreferredSizeWidget{
  const NaturalAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
        "Natural na sakuna",
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
          Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
        },
      ),
      
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}