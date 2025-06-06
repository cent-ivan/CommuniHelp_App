import 'package:communihelp_app/CommuniHelp_Responder/ViewModel/post_announcement_view_model.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/ViewModel/Connection_Controller/Controller/network_controller.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AnnouncementMake extends StatefulWidget {
  const AnnouncementMake({super.key});

  @override
  State<AnnouncementMake> createState() => _AnnouncementMakeState();
}

class _AnnouncementMakeState extends State<AnnouncementMake> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  final NetworkController network =  Get.put(NetworkController()); //checksconnction

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool isUrgent = false;

  String levelValue = "AKLAN";

  final postAnnouncementViewModel = PostAnnouncementViewModel();

  @override
  Widget build(BuildContext context) {
    //user data
    final userData = Provider.of<GetUserData>(context);
     //show current user
    User? curUser = FirebaseAuth.instance.currentUser;
    final responderSettings = UserSettingViewModel();
    responderSettings.loadSettings(curUser!.uid);
    var languageClass = Language(responderSettings.userLanguage);
    return Scaffold(
      appBar: AnnouncementAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16).r,
        child: SingleChildScrollView(
          child: SizedBox(
                height: 800.r,
                width: 500.r,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${languageClass.systemLang["MakeAnnounce"]["Today"]}: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                            style: TextStyle(
                              fontSize: 18.r,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline
                            ),
                          ),

                          
                        ],
                      ),
          
                      SizedBox(height: 20.r,),
          
          
                      Text(
                        languageClass.systemLang["MakeAnnounce"]["Title"],
                        style: TextStyle(
                          fontSize: 16.r,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.outline
                        ),
                      ),
          
                      SizedBox(height: 10.r,),
          
                      //Title Text Field
                      SizedBox(
                        height: 50.r,
                        width: 450.r,
                        child: TextFormField(
                          controller: _titleController,
                          style: TextStyle(
                              fontSize: 16.r,
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.bold
                            ),
                            cursorColor: Theme.of(context).colorScheme.outline,
                            decoration: InputDecoration(
                            hintText: languageClass.systemLang["MakeAnnounce"]["TitleHint"],
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
                      
                      SizedBox(height: 16.r,),
          
                      Text(
                        languageClass.systemLang["MakeAnnounce"]["Content"],
                        style: TextStyle(
                          fontSize: 16.r,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.outline
                        ),
                      ),
          
                      SizedBox(height: 10.r,),
          
                      //Content Text Field
                      SizedBox(
                        height: 200.r,
                        width: 450.r,
                        child: TextFormField(
                          controller: _contentController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          style: TextStyle(
                              fontSize: 16.r,
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.bold
                            ),
                            cursorColor: Theme.of(context).colorScheme.outline,
                            decoration: InputDecoration(
                            hintText: languageClass.systemLang["MakeAnnounce"]["ContentHint"],
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
          
                      SizedBox(height: 16.r,),
          
                      //Urgent and level section
                      Row(
                        children: [
                          //Urgent Switch
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                languageClass.systemLang["MakeAnnounce"]["Urgent"],
                                style: TextStyle(
                                  fontSize: 16.r,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.outline
                                ),
                              ),
                          
                              SizedBox(height: 8.r,),
                                  
                              Switch(
                                inactiveThumbColor: Theme.of(context).colorScheme.outline,
                                activeColor: const Color(0xFFFEAE49),
                                value: isUrgent, 
                                onChanged: (value) {
                                  setState(() {
                                    isUrgent = value;
                                  });
                                }
                              ),
                          
                            ],
                          ),
                          
                          SizedBox(width: 44.r,),
          
                          //Dropdown
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Level",
                                style: TextStyle(
                                  fontSize: 16.r,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.outline
                                ),
                              ),
          
                              DropdownButton(
                                value: levelValue,
                                items: [
                                  DropdownMenuItem(
                                    value: userData.municipality,
                                    child: Text("Municipal Level", style: TextStyle(color: Theme.of(context).colorScheme.outline),),
                                  ),
          
                                  DropdownMenuItem(
                                    value: "AKLAN",
                                    child: Text("Province Level", style: TextStyle(color: Theme.of(context).colorScheme.outline)),
                                  ),
          
                                  DropdownMenuItem(
                                    value: "NATIONAL",
                                    child: Text("National Level", style: TextStyle(color: Theme.of(context).colorScheme.outline)),
                                  ),
                                ], 
                                style: TextStyle( color: Theme.of(context).colorScheme.outline),
                                underline: Container(
                                  height: 2,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                dropdownColor: Theme.of(context).colorScheme.primary,
                                onChanged: (newValue) {
                                  setState(() {
                                    levelValue = newValue.toString();
                                  });
                                }
                              )
                            ],
                          )
                        ],
                      ),
          
                      
          
                      SizedBox(height: 24.r,),
          
                      //Post and Clear Buttons
                      Center(
                        child: Row(
                          children: [
                            MaterialButton(
                                height: 65.r,
                                minWidth: 150.r,
                                onPressed: () {
                                  if ( _titleController.text.isEmpty || _contentController.text.isEmpty) {
                                    showDialog(context: context, 
                                      builder: (context) {
                                        return SimpleDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(4.r),)
                                          ),
                                          contentPadding: EdgeInsets.all(12).r,
                                          children: [
                                            Center(child: Text(languageClass.systemLang["MakeAnnounce"]["NoContent"], style: TextStyle(fontWeight: FontWeight.bold),))
                                          ],
                                        );
                                      }
                                    );
                                  }
                                  else {
                                    postAnnouncementViewModel.addAnnouncement(isUrgent, _titleController.text, _contentController.text, levelValue, userData.municipality);
          
                                    setState(() {
                                      _titleController.clear();
                                      _contentController.clear();
                                      isUrgent = false;
                                      levelValue = "AKLAN";
                                    });
                                  }
                                     
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.r))
                                ),
                                color: Color(0xFFFEAE49),
                                elevation: 1.r,
                                child: Text(
                                  "Post",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.r,
                                    color: Theme.of(context).colorScheme.outline
                                  ),
                                ),
                            ),
                        
                            SizedBox(width: 10.r,),
                        
                            MaterialButton(
                                height: 65.r,
                                minWidth: 150.r,
                                disabledColor: const Color(0xFFADADAD),
                                onPressed: network.isOnline.value ?
                                () {
                                  setState(() {
                                    _titleController.clear();
                                    _contentController.clear();
                                    isUrgent = false;
                                    levelValue = "AKLAN";
                                  }); 
                                } : null,
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
                          ],
                        ),
                      )
                    
                    ],
                  ),
                ),
              ),
        ),
      )
    );
  }

  
}


//APP BAR----------------------------------------------------------------------------------------------------
class AnnouncementAppBar extends StatelessWidget implements PreferredSizeWidget{
  const AnnouncementAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? curUser = FirebaseAuth.instance.currentUser;
    final responderSettings = UserSettingViewModel();
    responderSettings.loadSettings(curUser!.uid);
    var languageClass = Language(responderSettings.userLanguage);
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),
          
        child: Text(
          languageClass.systemLang["MakeAnnounce"]["AnnounceTitle"],
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