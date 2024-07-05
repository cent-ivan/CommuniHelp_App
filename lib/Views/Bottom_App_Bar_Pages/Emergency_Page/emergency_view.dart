import 'package:communihelp_app/Views/Bottom_App_Bar_Pages/Emergency_Page/emergency_components/emergency_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  final int numberOfMDRRMO = 2; //count in database here
  final int numberOfAmbulance = 1;
  final int numberOfPolice = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const EmergencyAppBar(),

      body: EmergencyNumbers(numberOfMDRRMO: numberOfMDRRMO, numberOfAmbulance: numberOfAmbulance, numberOfPolice: numberOfPolice),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox.fromSize(
        size: Size.square(55.r),
        child: FloatingActionButton(
          elevation: 0.r,
          shape: const CircleBorder(),
          backgroundColor: Colors.redAccent,
          onPressed: () {
            
          },
          child: Icon(
            Icons.call,
            size: 25.r,
          ),
        ),
      ),
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
        "Magtawag it tabang",
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
            Navigator.popAndPushNamed(context, '/home');
          },
        ),
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}

class EmergencyContacts extends StatelessWidget {
  final int numberOfContacts;
  final Color? color;
  const EmergencyContacts({super.key, required this.numberOfContacts, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (110 * numberOfContacts.toDouble()).r,
      child: ListView.builder(
        itemCount: numberOfContacts,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8).r,
            child: MaterialButton(
                onPressed: () {},
                height: 100.r,
                minWidth: 350.r,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r))
                ),
                color: color,
                splashColor: const Color(0x80FEAE49),
                elevation: 0.r,
                child: Row(
                  children: [
                    //TODO: Change image, number and name of hotline
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0).r,
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundImage: const AssetImage('assets/images/rescuer.png'),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "09***********",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 16.r,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                      
                          Text(
                            "TNT - MDRRMO",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 12.r,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          );
        }
      ),
    );
  }
}