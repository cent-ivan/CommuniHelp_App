import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireView extends StatefulWidget {
  const FireView({super.key});

  @override
  State<FireView> createState() => _FireViewState();
}

class _FireViewState extends State<FireView> {
  @override
  Widget build(BuildContext context) {
    //show current user
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
        title: Text(
             languageClass.systemLang["ManmadeInfo"]["Fire"],
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
            
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Placeholder(),
    );
  }
}