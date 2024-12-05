import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShareAppView extends StatefulWidget {
  const ShareAppView({super.key});

  @override
  State<ShareAppView> createState() => _ShareAppViewState();
}

class _ShareAppViewState extends State<ShareAppView> {
  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
        title: Text(
          "Share App",
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
        
      ),
      body: Column(
        children: [
          SizedBox(height: 40.r,),
          Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: Text(
              languageClass.systemLang["Share"]["description"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.outline
              ),
            ),
          ),
          SizedBox(height: 20.r,),

          Container(
            height: 300.r,
            width: 300.r,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8).r
            ),
            child: Image.asset(
              'assets/images/qr_share.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}