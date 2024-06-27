import 'package:communihelp_app/Views/Pages/community_view.dart';
import 'package:communihelp_app/Views/Pages/contacts_view.dart';
import 'package:communihelp_app/Views/Pages/dashboard_view.dart';
import 'package:communihelp_app/Views/Pages/profile_view.dart';
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
        '/dashboard' : (context) => const DashboardView(),
        '/contacts' : (context) => const ContactsView(),
        '/community' : (context) => const CommunityView(),
        '/profile' : (context) => const ProfileView()
      },
    );
  }
}
