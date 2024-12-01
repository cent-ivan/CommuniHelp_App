import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/View/Utility_Pages/Report_Damage/pick_image_dialog.dart';
import 'package:communihelp_app/ViewModel/Connection_Controller/Controller/network_controller.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/report_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ReportDamageView extends StatefulWidget {
  const ReportDamageView({super.key});

  @override
  State<ReportDamageView> createState() => _ReportDamageViewState();
}

class _ReportDamageViewState extends State<ReportDamageView> {
  Logger logger = Logger(); //for debug message

  //user data
  final userData = GetUserData();
  
  //form global key
  final _formKey = GlobalKey<FormState>();


  final imageDialog = PickImageDialog();

  final NetworkController network =  Get.put(NetworkController()); //checksconnction

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ReportViewModel>(context);
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
      
        appBar: const ReportAppBar(),
      
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //sender details
                  Container(
                    decoration: BoxDecoration(
                      color:  Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(color: Theme.of(context).colorScheme.outline)
                    ),
                    padding: const EdgeInsets.all(8.0).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [                
                            
                            Column(      
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      languageClass.systemLang["Report"]["reportName"],
                                      style: TextStyle(
                                        fontSize: 20.r,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                    ),
                        
                                    SizedBox(width: 8.r),
                        
                                    //Title text field
                                    SizedBox(
                                      height: 50.r,
                                      width: 120.r,
                                      child: TextFormField(
                                        controller: viewModel.reportTitleController,
                                        style: TextStyle(
                                          color: Color(0xFFFEAE49),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.r
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4).r,
                                            borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8).r,
                                            borderSide: BorderSide(width: 1.5.r, color: Theme.of(context).colorScheme.outline)
                                          )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        
                              ],
                            ),
                                    
                          ],
                        ),
                                  
                        //Municipality
                        Text(
                          userData.municipality,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.r,
                            letterSpacing: 1.5.r
                          ),
                        ),
                                  
                        //Date
                        Text(
                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.r,
                            letterSpacing: 2
                          ),
                        ),
                      ],
                    ),
                  ),                
              
                  SizedBox(height: 16.r,),
                  Divider(height: 28.r,),
                  
                  //Contents
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        languageClass.systemLang["Report"]["reportLabel"],
                        style: TextStyle(
                          fontSize: 24.r,
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.bold
                        ),
                      ),
              
                      SizedBox(height: 24.r,),
                      
              
                      //LOCATION
                      Text(
                        languageClass.systemLang["Report"]["location"],
                        style: TextStyle(
                          fontSize: 20.r,
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 8.r,),
              
                      //Location Text Field
                      SizedBox(
                        height: 40.r,
                        width: 350.r,
                        child: TextFormField(
                          controller: viewModel.locationController,
                          style: TextStyle(
                            fontSize: 16.r,
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.bold
                          ),
                          cursorColor: Theme.of(context).colorScheme.outline,
                          decoration: InputDecoration(
                            hintText: languageClass.systemLang["Report"]["locationHint"],
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontStyle: FontStyle.italic
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8).r,
                              borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12).r,
                              borderSide: BorderSide(width: 1.5.r, color: Theme.of(context).colorScheme.outline)
                            )
                          ),
                        ),
                      ),
              
                      SizedBox(height: 24.r,),
                      
                      //CONTENT
                      Text(
                        languageClass.systemLang["Report"]["content"],
                        style: TextStyle(
                          fontSize: 20.r,
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 8.r,),
              
                      //content Text Field
                      SizedBox(
                        height: 120.r,
                        width: 350.r,
                        child: TextFormField(
                          controller: viewModel.contentController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          style: TextStyle(
                            fontSize: 16.r,
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.bold
                          ),
                          cursorColor: Theme.of(context).colorScheme.outline,
                          decoration: InputDecoration(
                            hintText: languageClass.systemLang["Report"]["contentHint"],
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontStyle: FontStyle.italic
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8).r,
                              borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12).r,
                              borderSide: BorderSide(width: 1.5.r, color: Theme.of(context).colorScheme.outline)
                            )
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 24.r,),
                      
                      //CONTENT
                      Text(
                        languageClass.systemLang["Report"]["uploadLabel"],
                        style: TextStyle(
                          fontSize: 20.r,
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 8.r,),

                      //Upload photo box
                      Center(
                        child: Container(
                          height: 200.r,
                          width: 250.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            border: Border.all(width: 1.5.r, color: Theme.of(context).colorScheme.outline),
                          ),
                          child: viewModel.choosenImage == null ?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 80.r,
                                child: MaterialButton(
                                  onPressed: () {
                                    imageDialog.showPickScreen(context);
                                  },
                                  child: const Image( 
                                    image: AssetImage('assets/images/dashboard/uploadphoto.png')
                                  ),
                                ),
                              ),
                        
                              TextButton(
                                onPressed: () {
                                  imageDialog.showPickScreen(context);
                                }, 
                                child: Text(
                                languageClass.systemLang["Report"]["uploadHint"],
                                style: TextStyle(
                                    color: Color(0xFFFEAE49),
                                    fontSize: 16.r,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ),
                        
                            ],
                          )
                          //else
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //shows big picture if tapped
                                  showDialog(context: context, 
                                  builder: (context) {
                                    return SimpleDialog(
                                      contentPadding: EdgeInsets.all(10).r,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8.r),)
                                      ),
                                      children: [
                                        Image.file(viewModel.choosenImage!, height: 250.r, width: 250.r, fit: BoxFit.cover,),
                                      ],
                                    );
                                  }
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0).r,
                                  child: Image.file(viewModel.choosenImage!, height: 130.r, width: 130.r, fit: BoxFit.cover,),
                                ),
                              ),

                              //Choose what button
                              MaterialButton(
                                height: 25.r,
                                minWidth: 40.r,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8.r))
                                ),
                                color: Color(0xFF57BEE6),
                                onPressed: (){
                                  setState(() {
                                    viewModel.choosenImage = null;
                                  });
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.r,
                                    color: Theme.of(context).colorScheme.outline
                                  ),
                                ),
                              ),

                            ],
                          )
                        ),
                      ),
                      
                      SizedBox(height: 32.r,),

                      //Save and Clear buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              MaterialButton(
                                disabledColor: const Color(0xFFADADAD),
                                height: 65.r,
                                minWidth: 150.r,
                                onPressed: network.isOnline.value ?
                                () {
                                  //shows dialog if empty one
                                  if (viewModel.reportTitleController.text.isEmpty || viewModel.contentController.text.isEmpty || viewModel.contentController.text.isEmpty || viewModel.choosenImage == null) {
                                    showDialog(context: context, 
                                    builder: (context) {
                                      return SimpleDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r),)
                                        ),
                                        title: Text("Empty input fields"),
                                        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.outline, fontWeight: FontWeight.bold, fontSize: 16.r),
                                        contentPadding: EdgeInsets.all(16).r,
                                        children: [
                                          Text("Please, fill up all input fields")
                                        ],
                                      );
                                    }
                                    );
                                  }
                                  else {
                                    logger.i("Posted");
                                    viewModel.postReport(context);
                                    setState(() {
                                      viewModel.reportTitleController.clear();
                                      viewModel.contentController.clear();
                                      viewModel.locationController.clear();
                                      viewModel.choosenImage = null;
                                    });
                                  }
                              
                              
                                } :
                                null,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.r))
                                ),
                                color: Color(0xFFFEAE49),
                                elevation: 1.r,
                                child: Text(
                                  "Send",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.r,
                                    color: Theme.of(context).colorScheme.outline
                                  ),
                                ),
                              ),

                              Text(
                                network.isOnline.value ? "" : "No internet. Cannot send",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 10.r,
                                  fontStyle: FontStyle.italic
                                ),
                              )
                            ],
                          ),

                          SizedBox(width: 10.r,),

                          Column(
                            children: [
                              MaterialButton(
                                height: 65.r,
                                minWidth: 150.r,
                                onPressed: () {
                                  setState(() {
                                    viewModel.reportTitleController.clear();
                                    viewModel.contentController.clear();
                                    viewModel.locationController.clear();
                                    viewModel.choosenImage = null;
                                  });
                                
                                  
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.r))
                                ),
                                color: Color(0xFF57BEE6),
                                elevation: 1.r,
                                child: Text(
                                  "Clear",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.r,
                                    color: Theme.of(context).colorScheme.outline
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.r,)
                            ],
                          ),

                          
                        ],
                      ),

                      SizedBox(height: 40.r,),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}



//APP BAR----------------------------------------------------------------------------------------------------
class ReportAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ReportAppBar({
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
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),
          
        child: Text(
          languageClass.systemLang["Report"]["appBarTitle"],
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
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}