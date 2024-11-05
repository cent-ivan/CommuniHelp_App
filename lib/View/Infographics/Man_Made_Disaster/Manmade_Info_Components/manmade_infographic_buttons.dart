import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../ViewModel/Inforgraphics_Controller/manmade_dis_view_model.dart';

class ManmadeInfoButtons extends StatelessWidget {
  const ManmadeInfoButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =  Provider.of<ManMadeDisasterViewModel>(context);
    return Column(
      children: [
        Text(
          "Kinds of Man-made Disasters",
          style: TextStyle(
            fontSize: 20.r,
            fontWeight: FontWeight.bold
          ),
        ),
        
        SizedBox(height: 15.r,),


        //Vehicular Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Vehicular", "En");
            Navigator.pushNamed(context, '/viewmanmadeinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/auto_accident.png"),
                    height: 40.r,
                  ),
                ),
                
                SizedBox(width: 40.r,),
        
                Text(
                  "Vehicular Incident",
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
        
        //Burn Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Burn", "En");
            Navigator.pushNamed(context, '/viewmanmadeinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/burn.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  "Fire related disaster",
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
    
        //Structural Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Structural", "En");
            Navigator.pushNamed(context, '/viewmanmadeinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/ruined.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  "Structural Failures",
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
    
        //Pollution Button
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          splashColor: const Color(0x80FEAE49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
          ),
          onPressed: () {
            viewModel.getPath("Pollution", "En");
            Navigator.pushNamed(context, '/viewmanmadeinfopage');
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image(
                    image: const AssetImage("assets/images/infographics/button_images/ocean.png"),
                    height: 40.r,
                  ),
                ),
        
                SizedBox(width: 40.r,),
        
                Text(
                  "Water Pollution",
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