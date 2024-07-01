import 'package:communihelp_app/ViewModels/theme.dart';
import 'package:communihelp_app/Views/Pages/Community_Page/community_view.dart';
import 'package:communihelp_app/Views/Pages/Contacts_Page/contacts_view.dart';
import 'package:communihelp_app/Views/Pages/Profile_Page/profile_view.dart';
import 'package:communihelp_app/Views/Pages/Emergency_Page/emergency_view.dart';
import 'package:communihelp_app/Views/base.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      home: const HomeBase(),
      routes: {
        '/home' : (context) => const HomeBase(),
        '/contacts' : (context) => const ContactsView(),
        '/community' : (context) => const CommunityView(),
        '/profile' : (context) => const ProfileView(),
        '/emergency': (context) => const EmergencyView()
      },
      theme: lightMode,
      darkTheme: darktMode,
    );
  }
}
