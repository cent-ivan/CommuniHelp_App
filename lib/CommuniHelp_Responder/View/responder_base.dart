import 'package:communihelp_app/CommuniHelp_Responder/View/Community_Page/community_view.dart';
import 'package:communihelp_app/CommuniHelp_Responder/View/Home_View/responder_dashboard_view.dart';
import 'package:communihelp_app/CommuniHelp_Responder/View/Profile_Page/profile_view.dart';
import 'package:communihelp_app/CommuniHelp_Responder/ViewModel/auth_responder.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Contacts_Page/contacts_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../ViewModel/Connection_Controller/Controller/network_controller.dart';

class HomeBaseResponder extends StatefulWidget {
  const HomeBaseResponder({super.key});

  @override
  State<HomeBaseResponder> createState() => _HomeBaseResponderState();
}

class _HomeBaseResponderState extends State<HomeBaseResponder>  with SingleTickerProviderStateMixin{
  final PageStorageBucket bucket = PageStorageBucket();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ResponderDashboardView(),
    const ContactsView(),
    
    const ResponderCommunityView(),
    const ResponderProfileView()
  ];
  

  final NetworkController network =  Get.put(NetworkController()); //checksconnction
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarBase(),

      drawer: DrawerBase(),

      body: PageStorage(
        bucket: bucket,
        child: _screens[_currentIndex],
      ),


      //BOTTOM APPBAR BASE
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 8).r,
        height: 85.r,
        elevation: 5.r,
        color: Theme.of(context).colorScheme.primary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.r,
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0).r,
          height: 40.r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Home Button
              MaterialButton(
                    minWidth: 25.r,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    splashColor: Theme.of(context).colorScheme.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
      
                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/Home.png'),
                            color: _currentIndex == 0? Theme.of(context).colorScheme.outline : Colors.grey,
                            width: _currentIndex == 0 ? 30.r : 20.r,
                          ),
                        ),
       
      
                        Expanded(
                          child: Text(
                            "Home",
                            style: TextStyle(
                              color: _currentIndex ==  0? Theme.of(context).colorScheme.outline : Colors.grey,
                              fontWeight: _currentIndex == 0? FontWeight.bold : FontWeight.normal,
                              fontSize: 12.r
                            ),
                          ),
                        )
                      ],
                    ),
              ), //Home Button

              //Contacts Button
              MaterialButton(
                    minWidth: 2.r,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    splashColor: Theme.of(context).colorScheme.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Icon(
                            Icons.phone,
                            color: _currentIndex == 1? Theme.of(context).colorScheme.outline : Colors.grey,
                            size: _currentIndex == 1 ? 30.r : 18.r,
                          )
                        ),
      
      
                        Expanded(
                          child: Text(
                            "Contacts",
                            style: TextStyle(
                              color: _currentIndex == 1 ? Theme.of(context).colorScheme.outline : Colors.grey,
                              fontWeight: _currentIndex == 1? FontWeight.bold : FontWeight.normal,
                              fontSize: 12.r
                            ),
                          ),
                        )
      
                      ],
                    ),
              ), //Contacts Button


               //Community Button
              MaterialButton(
                    minWidth: 20.r,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    splashColor: Theme.of(context).colorScheme.primary,
                    child: Column(
                      children: [
      
                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/People.png'),
                            color: _currentIndex == 2? Theme.of(context).colorScheme.outline : Colors.grey,
                            width: _currentIndex == 2 ? 30.r : 20.r,
                          ),
                        ),
      
                        Expanded(
                          child: Text(
                            "Community",
                            style: TextStyle(
                              color: _currentIndex == 2 ? Theme.of(context).colorScheme.outline: Colors.grey,
                              fontWeight: _currentIndex == 2? FontWeight.bold : FontWeight.normal,
                              fontSize: 12.r
                            ),
                          ),
                        )
      
                      ],
      
                    )
              ), //Community Button
      
              //Profile Button
              MaterialButton(
                    minWidth: 20.r,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    splashColor: Theme.of(context).colorScheme.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
      
                        Expanded(
                          child: Image(
                            image: const AssetImage('assets/images/bottom_app_bar/Profile.png'),
                            color: _currentIndex == 3? Theme.of(context).colorScheme.outline : Colors.grey,
                            width: _currentIndex == 3 ? 30.r : 20.r,
                          ),
                        ),
      
                      
                        Expanded(
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              color: _currentIndex == 3 ? Theme.of(context).colorScheme.outline : Colors.grey,
                              fontWeight: _currentIndex == 3? FontWeight.bold : FontWeight.normal,
                              fontSize: 12.r
                            ),
                          ),
                        )
      
                      ],
                    ),
              ),
      
            ],
          ),
        ),
      ),


    );
  }
}


//----------------------------------------------------------------------------------------
//APP BAR BASE 
class AppBarBase extends StatelessWidget implements PreferredSizeWidget{
  const AppBarBase({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0xFFFEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),

        child: Text(
          "Responder's Pad",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.r,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,

      //drawer
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        iconSize: 27.r,
        color: Theme.of(context).colorScheme.outline,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        }
      ),


      //notifications
      actions: [
        IconButton(
          onPressed: () {

          }, 
          icon: const Icon(Icons.notifications),
          iconSize: 30.r,
          color: Theme.of(context).colorScheme.outline,
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}

//--------------------------------------------------------------------------------------
//DRAWER WIDGET BASE
class DrawerBase extends StatelessWidget {
  DrawerBase({
    super.key,
  });

  final AuthResponder _auth = AuthResponder();

  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.fromLTRB(9, 9, 9, 3).r,
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/logo/communiHelpLogo.png'),
              ),
            ),
          ),
      
          //Drawer contents
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 9, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                //Home
                Container( 
                  margin: const EdgeInsets.only(bottom: 2), 
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home_filled), 
                        iconSize: 25,
                        color: Theme.of(context).colorScheme.outline,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
      
                      const SizedBox( width: 15,),
      
                      TextButton(
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ),
      

                //Notifications
                Container( 
                  margin: const EdgeInsets.only(bottom: 2), 
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notification_important), 
                        iconSize: 25,
                        color: Theme.of(context).colorScheme.outline,
                        onPressed: () {},
                      ),
                      
                      const SizedBox( width: 15,),
      
                      TextButton(
                        child: Text(
                          "Notifications",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        onPressed: (){
      
                        },
                      )
                    ],
                  )
                ),
      

                //Privacy Policy
                Container( 
                  margin: const EdgeInsets.only(bottom: 2), 
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings), 
                        iconSize: 25,
                        color: Theme.of(context).colorScheme.outline,
                        onPressed: () {
                          Navigator.pushNamed(context, '/respondersettings');
                        },
                      ),
                      
                      const SizedBox( width: 15,),
      
                      TextButton(
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/respondersettings');
                        },
                      )
                    ],
                  )
                ),


                //Share App
                Container( 
                  margin: const EdgeInsets.only(bottom: 2), 
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share), 
                        iconSize: 25,
                        color: Theme.of(context).colorScheme.outline,
                        onPressed: () {},
                      ),
                      
                      const SizedBox( width: 15,),
      
                      TextButton(
                        child: Text(
                          "Share App",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        onPressed: (){
      
                        },
                      )
                    ],
                  )
                ),
      
                //Rate Us 
                Container( 
                  margin: const EdgeInsets.only(bottom: 2), 
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.reviews_sharp), 
                        iconSize: 25,
                        color: Theme.of(context).colorScheme.outline,
                        onPressed: () {},
                      ),
      
                      const SizedBox( width: 15,),
      
                      TextButton(
                        child: Text(
                          "Rate Us",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        onPressed: (){
      
                        },
                      )
                    ],
                  )
                ),


                const SizedBox( height: 50,),

                //Logout
                Container(
                  width: 155,
                  height: 50,
                  margin: const EdgeInsets.only(left: 15),
                  child: MaterialButton(
                    elevation: 1,
                    color: const Color(0xE6FEAE49),
                    onPressed: () {
                      _auth.signOut(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          size: 28,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        
                        const SizedBox( width: 5,),
                  
                        Text(
                            "Logout",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                        )
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
      
      
        ],
      ),
    );
  }
}