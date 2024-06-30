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
        color:  Color(0x8CA4EACD),
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
                      color: const Color(0xFFB9EFD8),
                      splashColor: const Color(0x80FEAE49),
                      elevation: 3,
                      child: const Icon(
                        Icons.accessibility_sharp
                      ),
                    ),

                    const SizedBox(height: 10,),

                    Text(
                      "Natural Disaster",
                      style: TextStyle(
                        fontSize: 15,
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
                      color: const Color(0xFFB9EFD8),
                      splashColor: const Color(0x80FEAE49),
                      elevation: 3,
                      child: const Icon(
                        Icons.accessibility_sharp
                      ),
                    ),

                    const SizedBox(height: 10,),

                    Text(
                      "Man-made Disaster",
                      style: TextStyle(
                        fontSize: 15,
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
    return Container(
      height: 250,
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
            margin: const EdgeInsets.fromLTRB(9, 3, 9, 5),
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

