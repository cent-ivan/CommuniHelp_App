import 'package:communihelp_app/Views/Utility_Pages/Emergency_Kit/emergency_kit_components/add_dialog.dart';
import 'package:communihelp_app/Views/Utility_Pages/Emergency_Kit/emergency_kit_components/checklist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../ViewModels/Home_View_Models/emergency_kit_view_model.dart';

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

      body: const Pcard(),
    );
  }
}


//Emergency Checklist
class Pcard extends StatefulWidget {
  const Pcard({super.key});

  @override
  State<Pcard> createState() => _PcardState();
}

class _PcardState extends State<Pcard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0x4D57BEE6),
        ),
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emergency Kit Checklist', 
              style: TextStyle(
                fontSize: 18.r,
                color: const Color(0xFF3D424A),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Consumer<EmergencyKitViewModel>( builder: (context, emergencyValue, child) =>  ListView.builder (
                  itemCount: emergencyValue.importantsList.length,
                  itemBuilder: (BuildContext context, index) {
                    return ChecklistItem (
                      itemname: emergencyValue.importantsList[index].title!,
                      gotitem: emergencyValue.importantsList[index].isChecked!,
                      onChanged: (value) => emergencyValue.checkBoxChanged(index, value),
                      image: emergencyValue.importantsList[index].imagePath,
                      deleteFunction: (context) => emergencyValue.deleteitem(index),
                    );
                  },
                
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox.fromSize(
        size: Size.square(60.r),
        child: FloatingActionButton (
          shape: const CircleBorder(),
          backgroundColor:Colors.orange,
          onPressed: () => _addItemBox(),
          elevation: 0,
          child: const Icon(
            Icons.add, 
            size: 40, 
            color: Colors.white, 
            weight:1000,
          ),
        ),
      ),

    );
  }

  //shows the dialog for adding the item
  void _addItemBox() {
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<EmergencyKitViewModel>( builder: (context, emergencyValue, child) => AlertDialog(
            shape: RoundedRectangleBorder
              (
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            title: Text('Add New Item',
              style: TextStyle
                (
                fontSize: 20.r,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3D424A),
          
              ),
            ),
          
          
            content: AddChecklistDialog(
              textController: textController, 
              emergencyKitViewModel: emergencyValue
            ),
          
            actions: [
              TextButton(
                onPressed: () => emergencyValue.addItem(textController.text, context),
                child: Text('Add',
                    style: TextStyle(
                      fontSize: 20.r,
                      color: Colors.blue[900] ,
                      fontWeight: FontWeight.bold,
                  )
                ),
              ),
          
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel',
                  style: TextStyle(
                    fontSize: 20.r,
                    color: const Color(0xFF3D424A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

  }

}