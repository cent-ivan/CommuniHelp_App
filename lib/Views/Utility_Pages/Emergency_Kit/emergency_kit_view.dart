//to make the text color of the page adapt to dark mode enter this `Theme.of(context).colorScheme.outline`
//for the contact tiles here is the color: `Theme.of(context).colorScheme.primary`
//if you find the code to be difficult jsut search in youtube `To Do App in flutter`

//see the design in the figma link
//NOTE: pre-load the items stated in the design in the list
import 'package:flutter/material.dart';

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
        elevation: 1,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
          ).createShader(bounds),

          child: const Text(
            "CommuniHelp",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20,
          onPressed: () {
            Navigator.popAndPushNamed(context, '/home');
          },
        ),
      ),

      body: const Text("Enter Code here"),
    );
  }
}