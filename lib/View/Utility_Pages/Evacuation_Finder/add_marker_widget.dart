import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/View/Utility_Pages/Evacuation_Finder/evac_image_pick_dialog.dart';
import 'package:communihelp_app/ViewModel/Connection_Controller/Controller/network_controller.dart';
import 'package:communihelp_app/ViewModel/Evacuation_Finder_View_Models/evacuation_finder_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/Settings_View_Models/user_setting_view_model.dart';

class AddMarker extends StatefulWidget {
  const AddMarker({super.key});

  @override
  State<AddMarker> createState() => _AddMarkerState();
}

class _AddMarkerState extends State<AddMarker> {
  Logger logger = Logger(); //for debug message
  
  //form global key
  final _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController(); //for adding 

  final imageDialog = EvacImagePickDialog();

  final userData = GetUserData();
  final NetworkController network =  Get.put(NetworkController()); //checksconnction

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EvacuationFinderViewModel>(context);

    // User? curUser = FirebaseAuth.instance.currentUser;
    // final settings = UserSettingViewModel();
    // settings.loadSettings(curUser!.uid);
    // var languageClass = Language(settings.userLanguage);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
      
        appBar: const AddAppBar(),
      
        //Tab contents, entre code here
        body: Container(
          height: 1200.r,
          padding: EdgeInsets.all(12).r,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface
          ),

          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Stack(
                    
                    children: [
                      Positioned(
                        top: 100,
                        left: 20,
                        child: Container(
                          padding: EdgeInsets.all(12).r,
                          decoration: BoxDecoration(
                            color:  Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8).r,
                            border: Border.all(color: Theme.of(context).colorScheme.outline)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on, color: Theme.of(context).colorScheme.outline,),
                                  Text(
                                    "Enter evacuation details",
                                    style: TextStyle(
                                      color:  Theme.of(context).colorScheme.outline,
                                      fontSize: 16.r,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12,),

                              Row(
                                children: [
                                  SizedBox(
                                    width: 200.r,
                                    child: TextFormField(
                                    controller: title,
                                    style: TextStyle(
                                      fontSize: 12.r,
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Enter name',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4).r,
                                        borderSide: BorderSide(width: 1.r, color:Theme.of(context).colorScheme.outline,)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8).r,
                                        borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline,)
                                      )
                                    ),
                                    
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 3,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter a name";
                                      }
                                      return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 8,),

                                  Padding(
                                    padding: EdgeInsets.all(8).r,
                                    child: GestureDetector(
                                      onTap: () {
                                        imageDialog.showPickScreen(context);
                                      },
                                      child: Image(
                                        image: AssetImage('assets/images/dashboard/uploadphoto.png'),
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              viewModel.choosenImage == null ? SizedBox(height: 16,):
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: EdgeInsets.all(12).r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  border: Border.all(color: Theme.of(context).colorScheme.outline,)
                                ),
                                child: Image(
                                  image: FileImage(viewModel.choosenImage!),
                                  height: 230.r,
                                  width: 230.r,
                                ),
                              ),
                              SizedBox(height: 12.r,),

                              Row(
                                children: [
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Theme.of(context).colorScheme.outline),
                                      borderRadius: BorderRadius.all(Radius.circular(8.r),)
                                    ),
                                    onPressed: () {
                                      //sends pos to firestore
                                      if (_formKey.currentState!.validate()) {
                                        viewModel.addEvacFirebase(userData.municipality, title.text, viewModel.evacPos!);
                                        viewModel.placedPin = null;
                                        viewModel.pinMode = false;
                                        title.clear();
                                        viewModel.choosenImage = null;

                                        Navigator.popAndPushNamed(context, '/evacuationfinder');
                                      }
                                    },
                                    child: Text("PIN", style: TextStyle(color: Theme.of(context).colorScheme.outline, fontWeight: FontWeight.bold),),
                                  ),
                                  

                                  MaterialButton(
                                    onPressed: () {
                                      //exits dialog
                                      viewModel.choosenImage = null;
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel", style: TextStyle(color: Theme.of(context).colorScheme.outline, fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                  
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        )

      ),
    );
  }
}


//APP BAR----------------------------------------------------------------------------------------------------
class AddAppBar extends StatelessWidget implements PreferredSizeWidget{
  const AddAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      centerTitle: true,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),
          
        child: Text(
          "Add Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
          
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}