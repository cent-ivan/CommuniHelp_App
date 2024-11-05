import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Community_Page/community_view.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Contacts_Page/contacts_view.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Home_Page/dashboard_view.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Profile_Page/profile_view.dart';
import 'package:flutter/material.dart';

class BaseController extends ChangeNotifier{
  int currentIndex = 0;

  final List<Widget> screens = [
    const DashboardView(),
    const ContactsView(),
    const CommunityView(),
    const ProfileView()
  ];

  void switchPage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}