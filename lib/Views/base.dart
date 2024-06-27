import 'package:communihelp_app/Views/Pages/community_view.dart';
import 'package:communihelp_app/Views/Pages/contacts_view.dart';
import 'package:communihelp_app/Views/Pages/dashboard_view.dart';
import 'package:communihelp_app/Views/Pages/profile_view.dart';
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

      //TO DO: create UI to PageView then compare
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //LEFT Side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Home Button
                  MaterialButton(
                    minWidth: 40,
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
                            color: _currentIndex == 0? Colors.blue : Colors.grey,
                          ),
                        ),

                        Expanded(
                          child: Text(
                            "Home",
                            style: TextStyle(
                              color: _currentIndex == 0 ? Colors.blue : Colors.grey,
                              fontSize: 15
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //Home Button


                  //Contacts Button
                  MaterialButton(
                    minWidth: 40,
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
                            color: _currentIndex == 1? Colors.blue : Colors.grey,
                          ),
                        ),

                        Expanded(
                          child: Text(
                            "Contacts",
                            style: TextStyle(
                              color: _currentIndex == 1 ? Colors.blue : Colors.grey,
                              fontSize: 15
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //Contacts Button
                ],
              ), //LEFT

              //const SizedBox(width: 1,),

              //RIGHT Side
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Community Button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/People.png'),
                            color: _currentIndex == 2? Colors.blue : Colors.grey,
                          ),
                        ),

                        Expanded(
                          child: Text(
                            "Community",
                            style: TextStyle(
                              color: _currentIndex == 2 ? Colors.blue : Colors.grey,
                              fontSize: 15
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //Community Button


                  //Profile Button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/Profile.png'),
                            color: _currentIndex == 3? Colors.blue : Colors.grey,
                          ),
                        ),

                        Expanded(
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              color: _currentIndex == 3 ? Colors.blue : Colors.grey,
                              fontSize: 15
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //Profile Button
                ],
              )
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
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Color(0xFF57BEE6),//Color.fromRGBO(1,87,155,1.000), 
          letterSpacing: 1.5
        ),
      ),
    
      backgroundColor: Colors.transparent,
      elevation: 0,

      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        iconSize: 27,
        color: const Color(0xFF57BEE6),//const Color.fromRGBO(1,87,155,1.000),
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
        color: const Color.fromARGB(255, 224, 224, 224),
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