
import 'package:communihelp_app/ViewModel/Home_View_Models/emergency_view_model.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Emergency_Page/emergency_components/emergency_buttons.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  Logger logger = Logger();

  

  @override
  void initState() {
    super.initState();
    initSimInfoState();
  }

  Future<void> initSimInfoState() async {
    var status = await Permission.phone.request();
    
    if (status.isDenied) {
      await Permission.phone.request();
    }
    else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const EmergencyAppBar(),

      body: const EmergencyNumbers(),
    );

  }
}



//-------------------------------------------------------------------------------------------------
//EMERGENCY APP BAR
class EmergencyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmergencyAppBar({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1.r,
      title: Text(
        "Emergency Contacts",
        style: TextStyle(
          color: Theme.of(context).colorScheme.outline,
          fontSize: 23.r,
          fontWeight: FontWeight.bold
        ),
      ),
    
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20.r,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}


class EmergencyNumbers extends StatefulWidget {
  const EmergencyNumbers({super.key,});

  @override
  State<EmergencyNumbers> createState() => _EmergencyNumbersState();
}

class _EmergencyNumbersState extends State<EmergencyNumbers> {
  //show current user
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final settings = UserSettingViewModel();
    settings.loadSettings(user.uid);
    var languageClass = Language(settings.userLanguage); //catches aklanon language to replace with filipino
    return Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => SingleChildScrollView(
      
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 40, 20),
          child: SizedBox(
            height: (800 * (viewModel.mddrmoContacts.length.toDouble()) + ((viewModel.ambulanceContacts.length.toDouble()) + (viewModel.bfpContacts.length.toDouble()) + (viewModel.cgContacts.length.toDouble()))).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                
                //Municipality Tag
                GestureDetector(
                  onTap: () {
                    setState(() {
                      
                      viewModel.loadMunicipality(context);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(15.r))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10).r,
                      child: Text(
                        viewModel.municipalityName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 16.r,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
                    
                    
                SizedBox(height: 12.r,),
      
                //MDDRMO Title
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(9, 25, 9, 10).r,
                      child: Text(
                        "LDDRMO Rescuers",
                        style: TextStyle(
                          fontSize: 20.r,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.outline, 
                        ),
                      ),
                    ),
                        
                    //LDRRMO Number
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: viewModel.mddrmoContacts.isEmpty ? null
                        : LDRRMOButton(numberOfContacts: viewModel.mddrmoContacts.length,color: const Color(0xBFFEAE49),
                      )
                    ),
                  ],
                ),

                SizedBox(height: 15.r,),
                    
                    
                //Ambulance Title
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(9, 25, 9, 10).r,
                  child: Text(
                    languageClass.systemLang["Emergency"]["host"],
                    style: TextStyle(
                      fontSize: 20.r,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ),
                    
                //Ambulance number
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: viewModel.ambulanceContacts.isEmpty ? Container(color: Colors.amber,)
                  : AmbulanceButton(numberOfContacts: viewModel.ambulanceContacts.length, color: const Color(0xFFF2F2F2), 
                  )
                ),
      

                SizedBox(height: 15.r,),
                    
                //bombero Title
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(9, 25, 9, 10).r,
                  child: Text(
                    languageClass.systemLang["Emergency"]["fire"],
                    style: TextStyle(
                      fontSize: 20.r,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ),
                    
                //bombero number
                ClipRRect(
                  borderRadius: BorderRadius.circular(15).r,
                  child: BFPButton(numberOfContacts: viewModel.bfpContacts.length, color: Colors.amber[300], )
                ),
                
                SizedBox(height: 10.r,),
                    
                //Costguard Title
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(9, 25, 9, 10).r,
                  child: Text(
                    languageClass.systemLang["Emergency"]["coast"],
                    style: TextStyle(
                      fontSize: 20.r,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ),
                    
                //Coastgaurd number
                ClipRRect(
                  borderRadius: BorderRadius.circular(15).r,
                  child: CoastButton(numberOfContacts: viewModel.cgContacts.length, color: const Color.fromARGB(255, 248, 181, 113), )
                ),
      
              ],
            ),
          ),
        ),
      )
    );
  }
}
