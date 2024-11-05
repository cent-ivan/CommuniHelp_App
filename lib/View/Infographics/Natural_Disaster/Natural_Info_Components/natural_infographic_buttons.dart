import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NaturalInfoButtons extends StatelessWidget {
  const NaturalInfoButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =  Provider.of<NaturalDisasterViewModel>(context);
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
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Typhoon", "En");
            Navigator.pushNamed(context, '/viewinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/Typhoon.png"),
                    height: 40.r,
                  ),
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
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Flood", "En");
            Navigator.pushNamed(context, '/viewinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/Floods.png"),
                    height: 40.r,
                  ),
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
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Landslide", "En");
            Navigator.pushNamed(context, '/viewinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/Landslide.png"),
                    height: 40.r,
                  ),
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
    
        //Earthquake Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Earthquake", "En");
            Navigator.pushNamed(context, '/viewinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/Earthquake.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  "Linog",
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