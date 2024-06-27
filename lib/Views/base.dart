import 'package:communihelp_app/Views/Pages/Community_Page/community_view.dart';
import 'package:communihelp_app/Views/Pages/Contacts_Page/contacts_view.dart';
import 'package:communihelp_app/Views/Pages/Dashboard_Page/dashboard_view.dart';
import 'package:communihelp_app/Views/Pages/Profile_Page/profile_view.dart';
import 'package:flutter/material.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({super.key});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  final PageStorageBucket bucket = PageStorageBucket();
  int _currentIndex = 0;


  final List<Widget> _screens = [
    const DashboardView(),
    const ContactsView(),
    const CommunityView(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const BaseAppBar(),

      drawer: const BaseDrawer(),

      body: PageStorage(
        bucket: bucket,
        child: _screens[_currentIndex],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BaseFloatingActionButton(),

      //BASE BOTTOM APPBAR 
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        height: 58,
        elevation: 0,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //LEFT Side
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Home Button
                  MaterialButton(
                    minWidth: 25,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
      
                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/Home.png'),
                            color: _currentIndex == 0? const Color(0xFF3D424A) : Colors.grey,
                            width: _currentIndex == 0 ? 30 : 20,
                          ),
                        ),
       
      
                        Expanded(
                          flex: 0,
                          child: Text(
                            "Home",
                            style: TextStyle(
                              color: _currentIndex ==  0? const Color(0xFF3D424A) : Colors.grey,
                              fontWeight: _currentIndex == 0? FontWeight.bold : FontWeight.normal,
                              fontSize: 12
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //Home Button
      
                  const SizedBox(width: 5,),
      
                  //Contacts Button
                  MaterialButton(
                    minWidth: 25,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
      
                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/FindMale.png'),
                            color: _currentIndex == 1? const Color(0xFF3D424A) : Colors.grey,
                            width: _currentIndex == 1 ? 30 : 20,
                          ),
                        ),
      
                        Expanded(
                          flex: 0,
                          child: Text(
                            "Contacts",
                            style: TextStyle(
                              color: _currentIndex == 1 ? const Color(0xFF3D424A) : Colors.grey,
                              fontWeight: _currentIndex == 1? FontWeight.bold : FontWeight.normal,
                              fontSize: 12
                            ),
                          ),
                        )
      
                      ],
                    ),
                  ), //Contacts Button
                ],
              ), //LEFT
      
      
              //RIGHT Side
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Community Button
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      children: [
      
                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/People.png'),
                            color: _currentIndex == 2? const Color(0xFF3D424A) : Colors.grey,
                            width: _currentIndex == 2 ? 30 : 20,
                          ),
                        ),
      
                        Expanded(
                          flex: 0,
                          child: Text(
                            "Forum",
                            style: TextStyle(
                              color: _currentIndex == 2 ? const Color(0xFF3D424A) : Colors.grey,
                              fontWeight: _currentIndex == 2? FontWeight.bold : FontWeight.normal,
                              fontSize: 12
                            ),
                          ),
                        )
      
                      ],
      
                    )
                  ), //Community Button
      
      
                  //Profile Button
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
      
                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/Profile.png'),
                            color: _currentIndex == 3? const Color(0xFF3D424A) : Colors.grey,
                            width: _currentIndex == 3 ? 30 : 20,
                          ),
                        ),
      
                      
                        Expanded(
                          flex: 0,
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              color: _currentIndex == 3 ? const Color(0xFF3D424A) : Colors.grey,
                              fontWeight: _currentIndex == 3? FontWeight.bold : FontWeight.normal,
                              fontSize: 12
                            ),
                          ),
                        )
      
                      ],
                    ),
                  ), //Profile Button
                ],
              ) //RIGHT
      
            ],
          ),
        ),
      ),


    );
  }
}





//----------------------------------------------------------------------------------------
//BASE APP BAR
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  const BaseAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "CommuniHelp",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF57BEE6),
          letterSpacing: 1.5
        ),
      ),
    
      backgroundColor: Colors.transparent,
      elevation: 0,

      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        iconSize: 27,
        color: const Color(0xFF3D424A),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),

      //notifications
      actions: [
        IconButton(
          onPressed: () {

          }, 
          icon: const Icon(Icons.notifications),
          iconSize: 30,
          color: const Color(0xFF57BEE6),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


//BASE DRAWER WIDGET
class BaseDrawer extends StatelessWidget {
  const BaseDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: const Color(0xFF57BEE6),
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: ListView(
          children: const [
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(9, 9, 9, 3),
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/logo/communiHelpLogo.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//BASE FLOATING ACTION BUTTON
class BaseFloatingActionButton extends StatelessWidget {
  const BaseFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      shape: const CircleBorder(),
      onPressed: () {
        
      },
      backgroundColor: const Color(0xFFFEAE49),
      foregroundColor: const Color(0xFFFFFFFF),
      splashColor: Colors.redAccent,
      child: const Icon(Icons.call),
    );
  }
}