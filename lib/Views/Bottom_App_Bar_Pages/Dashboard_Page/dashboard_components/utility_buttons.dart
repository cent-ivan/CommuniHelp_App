//Utility Buttons
import 'package:flutter/material.dart';

class UtilityButtons extends StatelessWidget {
  const UtilityButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        //----------------------------------------------------------------------------------------------------------
            
        Wrap(
          spacing: 5,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/evacuationfinder');
              },
              height: 80,
              minWidth: 100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              color: Theme.of(context).colorScheme.primary,
              splashColor: const Color(0x4D57BEE6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    width: 35,
                    image: AssetImage('assets/images/dashboard/searchevac.png')
                  ),
            
                  Center(
                    child: Text(
                    "Magusoy it Evacuation Center",
                        style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline, 
                      ),
                    ),
                  ),
                ],
              )
            ),
                
            MaterialButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/newsfeed');
              },
              height: 80,
              minWidth: 100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              color: Theme.of(context).colorScheme.primary,
              splashColor: const Color(0x4D57BEE6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    width: 35,
                    image: AssetImage('assets/images/dashboard/newspaper.png')
                  ),
            
                  Text(
                  "Mga Balita",
                      style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ],
              )
            ),
                
            MaterialButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/weatherupdate');
              },
              height: 80,
              minWidth: 100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              color: Theme.of(context).colorScheme.primary,
              splashColor: const Color(0x4D57BEE6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    width: 35,
                    image: AssetImage('assets/images/dashboard/weather.png')
                  ),
            
                  Text(
                  "Ang Panahon",
                      style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ],
              )
            ),
                
            MaterialButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/emergencykit');
              },
              height: 80,
              minWidth: 100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              color: Theme.of(context).colorScheme.primary,
              splashColor: const Color(0x4D57BEE6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    width: 35,
                    image: AssetImage('assets/images/dashboard/mykit.png')
                  ),
            
                  Text(
                  "Akong Kit",
                      style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ],
              )
            ),
        
            MaterialButton(
              onPressed: () {},
              height: 80,
              minWidth: 120,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              color: Theme.of(context).colorScheme.primary,
              splashColor: const Color(0x4D57BEE6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    width: 35,
                    image: AssetImage('assets/images/dashboard/flashlight.png')
                  ),
            
                  Text(
                  "Led Light",
                      style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ],
              )
            ),
        
            MaterialButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/radio');
              },
              height: 80,
              minWidth: 120,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              color: Theme.of(context).colorScheme.primary,
              splashColor: const Color(0x4D57BEE6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    width: 35,
                    image: AssetImage('assets/images/dashboard/radio.png')
                  ),
            
                  Text(
                  "Pamati it Radyo",
                      style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                  ),
                ],
              )
            ),
        
          ],
        ),

        //----------------------------------------------------------------------------------------------------------
        Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.fromLTRB(10,10,10,15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(9))
          ),
          child: Wrap(
            spacing: 5,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [

              Center(
                child: Text(
                  "Magpadaea it Report",
                      style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline, 
                    ),
                ),
              ),
                 
              MaterialButton(
                onPressed: () {},
                height: 80,
                minWidth: 100,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                color: Theme.of(context).colorScheme.primary,
                splashColor: const Color(0x4D57BEE6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      width: 35,
                      image: AssetImage('assets/images/dashboard/file.png')
                    ),
              
                    Text(
                    "Report Damage",
                        style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline, 
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
    
      ],
    );
  }
}//Utiltity Section