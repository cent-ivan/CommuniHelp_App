//Infographics Section
import 'package:communihelp_app/Views/Pages/Dashboard_Page/dashboard_components/utility_buttons.dart';
import 'package:flutter/material.dart';

class InfographicsSection extends StatelessWidget {
  const InfographicsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(9, 0, 9, 12),
      decoration: const BoxDecoration(
        color:  Color(0x80A4EACD),
        borderRadius: BorderRadius.all(Radius.circular(18 ))
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(9, 3, 9, 6),
            child: Text(
              "Infographics",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.outline, 
              ),
            ),
          ),
      
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Column(
                  children: [
                    
                    //Natural Disaster Button
                    MaterialButton(
                      onPressed: () {},
                      height: 100,
                      minWidth: 150,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      splashColor: const Color(0xFFB9EFD8),
                      elevation: 3,
                      child: const Image(
                        width: 55,
                        image: AssetImage('assets/images/dashboard/natural.png')
                      )
                    ),

                    const SizedBox(height: 10,),

                    Text(
                      "Natural na sakuna",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.outline, 
                      ),
                    ),
                  ],
                ),
    
                const SizedBox(width: 10,),
            
                Column(
                  children: [
                    
                    //Man-made Disaster Button
                    MaterialButton(
                      onPressed: () {},
                      height: 100,
                      minWidth: 150,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      splashColor: const Color(0x80FEAE49),
                      elevation: 3,
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white54,
                        child: Image(
                          width: 55,
                          image: AssetImage('assets/images/dashboard/manmade.png')
                        ),
                      )
                    ),

                    const SizedBox(height: 10,),

                    Text(
                      "Kalamidad na ubra it tawo",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.outline, 
                      ),
                    ),
                  ],
                ),
            
              ],
            ),
          )
        ],
      ),
    );
  }
}//Inforgraphic Section



//Utiltity Section
class UtilitySection extends StatelessWidget {
  const UtilitySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Container of Utility Section
    return Container(
      height: 515,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(9, 15, 9, 9),
      decoration: const BoxDecoration(
        color:  Color(0x4D57BEE6),
        borderRadius: BorderRadius.all(Radius.circular(18 ))
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(9, 3, 9, 15),
            child: Text(
              "Utility",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.outline, 
              ),
            ),
          ),

          const UtilityButtons()

        ],
      ),
    );
  }
}

