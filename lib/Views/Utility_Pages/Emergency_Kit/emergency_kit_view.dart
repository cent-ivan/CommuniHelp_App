//to make the text color of the page adapt to dark mode enter this `Theme.of(context).colorScheme.outline`
//for the contact tiles here is the color: `Theme.of(context).colorScheme.primary`
//if you find the code to be difficult jsut search in youtube `To Do App in flutter`

//see the design in the figma link
//NOTE: pre-load the items stated in the design in the list
//when putting sizes in double data type add `.r` at the end Ex: 13.r/ EdgeInsets.all(13).r for paddings
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmergencyKitView extends StatefulWidget {
  const EmergencyKitView({super.key});

  @override
  State<EmergencyKitView> createState() => _EmergencyKitViewState();
}

class _EmergencyKitViewState extends State<EmergencyKitView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1.r,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
          ).createShader(bounds),

          child: Text(
            "CommuniHelp",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.r,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20.r,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
          },
        ),
      ),

      body: const Text("Enter Code here"),
    );
  }
}