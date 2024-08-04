import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NaturalInfoButtons extends StatelessWidget {
  const NaturalInfoButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Uri it Natural na sakuna",
          style: TextStyle(
            fontSize: 20.r,
            fontWeight: FontWeight.bold
          ),
        ),
        
        SizedBox(height: 15.r,),


        //Typhoon Button
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
        
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                Image(
                  image: const AssetImage("assets/images/infographics/button_images/Typhoon.png"),
                  height: 40.r,
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  "Bagyo",
                  style: TextStyle(
                    fontSize: 18.r,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),

        SizedBox(height: 10.r,),
        
        //Flood Button
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
        
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                Image(
                  image: const AssetImage("assets/images/infographics/button_images/Floods.png"),
                  height: 40.r,
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  "Baha",
                  style: TextStyle(
                    fontSize: 18.r,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
    
        SizedBox(height: 10.r,),
    
        //Landslide Button
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
        
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                Image(
                  image: const AssetImage("assets/images/infographics/button_images/Landslide.png"),
                  height: 40.r,
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  "Landslide",
                  style: TextStyle(
                    fontSize: 18.r,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
    
        SizedBox(height: 10.r,),
    
        //Tornado Button
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
        
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                Image(
                  image: const AssetImage("assets/images/infographics/button_images/Tornado.png"),
                  height: 40.r,
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  "Buhawi",
                  style: TextStyle(
                    fontSize: 18.r,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),

        SizedBox(height: 10.r,),
    
      ],
    );
  }
}