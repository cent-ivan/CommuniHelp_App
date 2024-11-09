import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class UserSettingsView extends StatefulWidget {
  const UserSettingsView({super.key});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

List<String> options =["En", "Fil", "Akl"]; //for radio list

class _UserSettingsViewState extends State<UserSettingsView> {
  

  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
  
    final viewModel = Provider.of<UserSettingViewModel>(context);
    //language current value
    String currentOption = viewModel.userLanguage;

    var languageClass = Language(currentOption);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: SettingsAppBar(),
      body: Padding(
        padding: EdgeInsets.all(12).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              languageClass.systemLang["Settings"]["DisplaySetting"],
              style: TextStyle(
                fontSize: 24.r,
                color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 8.r,),

            //Light and Dark Theme
            Theme.of(context).brightness == Brightness.light? Text(
              languageClass.systemLang["Settings"]["SwitchLightMode"],
              style: TextStyle(
                fontSize: 16.r,
                color: Theme.of(context).colorScheme.outline
              ),
            ) :
            Text(
              languageClass.systemLang["Settings"]["SwitchDarkMode"],
              style: TextStyle(
                fontSize: 16.r,
                color: Theme.of(context).colorScheme.outline
              ),
            ),

            SizedBox(height: 4.r,),
            
            //the switch 
            Switch(
              inactiveThumbColor: Colors.grey,
              activeColor: Color(0xFF3D424A),
              value:  Theme.of(context).brightness == Brightness.light ? true : false , 
              onChanged: (value) {
                viewModel.toggleTheme();     
                viewModel.addPreference(curUser!.uid);
                viewModel.updateDB(curUser!.uid); 
              }
            ),

            Divider(color: Theme.of(context).colorScheme.outline, height: 28.r,),

            Text(
              languageClass.systemLang["Settings"]["Preffered"],
              style: TextStyle(
                fontSize: 24.r,
                color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 8.r,),

            //languag radio select
            Column(
              children: [
                //English radio
                Row(
                  children: [
                    Radio(
                      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Theme.of(context).colorScheme.outline;
                        }
                        return Theme.of(context).colorScheme.outline;
                      }),
                      value: options[0], 
                      groupValue: currentOption, 
                      onChanged: (value) {
                        viewModel.changeLanguag(value.toString());
                        viewModel.addPreference(curUser!.uid);
                        viewModel.updateDB(curUser!.uid);
                      }
                    ),

                    Text(
                      "English",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 16.r
                      ),
                    )
                  ],
                ),

                //Filipno radio
                Row(
                  children: [
                    Radio(
                      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Theme.of(context).colorScheme.outline;
                        }
                        return Theme.of(context).colorScheme.outline;
                      }),
                      value: options[1], 
                      groupValue: currentOption, 
                      onChanged: (value) {
                        viewModel.changeLanguag(value.toString());
                        viewModel.addPreference(curUser!.uid);
                        viewModel.updateDB(curUser!.uid);
                      }
                    ),

                    Text(
                      "Filipino",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 16.r
                      ),
                    )
                  ],
                ),

                //Akeanon radio
                Row(
                  children: [
                    Radio(
                      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Theme.of(context).colorScheme.outline;
                        }
                        return Theme.of(context).colorScheme.outline;
                      }),
                      value: options[2], 
                      groupValue: currentOption, 
                      onChanged: (value) {
                        viewModel.changeLanguag(value.toString());
                        viewModel.addPreference(curUser!.uid);
                        viewModel.updateDB(curUser!.uid);
                      }
                    ),

                    Text(
                      "Akeanon",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 16.r
                      ),
                    )
                  ],
                ),
              ],
            ),

            SizedBox(height: 24.r,),

            Row(
              children: [
                MaterialButton(
                    height: 35.r,
                    minWidth: 65.r,
                    color: const Color(0xFFFEAE49),
                    onPressed: () {
                      viewModel.addPreference(curUser!.uid);
                      viewModel.updateDB(curUser!.uid);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 12.r
                      ),
                    ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}


//APP BAR--------------------------------------------------------------------------------------
class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SettingsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
        "Settings",
        style: TextStyle(
          color: Theme.of(context).colorScheme.outline,
          fontSize: 20.r,
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