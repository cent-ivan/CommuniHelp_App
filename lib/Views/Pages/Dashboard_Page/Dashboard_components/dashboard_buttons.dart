//Infographics Section
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
            margin: const EdgeInsets.fromLTRB(9, 3, 9, 5),
            child: const Text(
              "Infographics",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D424A), 
              ),
            ),
          ),
      
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Column(
                  children: [

                    MaterialButton(
                      onPressed: () {},
                      height: 100,
                      minWidth: 150,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      color: Colors.white,
                      child: const Icon(
                        Icons.accessibility_sharp
                      ),
                    ),

                    const SizedBox(height: 5,),

                    const Text(
                      "Natural Disaster",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3D424A), 
                      ),
                    ),
                  ],
                ),
    
                const SizedBox(width: 10,),
            
                Column(
                  children: [

                    MaterialButton(
                      onPressed: () {},
                      height: 100,
                      minWidth: 150,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      color: Colors.white,
                      child: const Icon(
                        Icons.accessibility_sharp
                      ),
                    ),

                    const SizedBox(height: 5,),

                    const Text(
                      "Man-made Disaster",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3D424A), 
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
      margin: const EdgeInsets.fromLTRB(9, 5, 9, 9),
      decoration: const BoxDecoration(
        color:  Color(0x4D57BEE6),
        borderRadius: BorderRadius.all(Radius.circular(18 ))
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(9, 3, 9, 5),
            child: const Text(
              "Utility",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D424A), 
              ),
            ),
          ),

          const UtilityButtons()

        ],
      ),
    );
  }
}


//Utility Buttons
class UtilityButtons extends StatelessWidget {
  const UtilityButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 15,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {},
          height: 80,
          minWidth: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          color: Colors.white,
          child: const Icon(
            Icons.accessibility_sharp
          ),
        ),
    
        MaterialButton(
          onPressed: () {},
          height: 80,
          minWidth: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          color: Colors.white,
          child: const Icon(
            Icons.accessibility_sharp
          ),
        ),
    
        MaterialButton(
          onPressed: () {},
          height: 80,
          minWidth: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          color: Colors.white,
          child: const Icon(
            Icons.accessibility_sharp
          ),
        ),
    
        MaterialButton(
          onPressed: () {},
          height: 80,
          minWidth: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          color: Colors.white,
          child: const Icon(
            Icons.accessibility_sharp
          ),
        ),
    
        MaterialButton(
          onPressed: () {},
          height: 80,
          minWidth: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          color: Colors.white,
          child: const Icon(
            Icons.accessibility_sharp
          ),
        ),
    
        MaterialButton(
          onPressed: () {},
          height: 80,
          minWidth: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          color: Colors.white,
          child: const Icon(
            Icons.accessibility_sharp
          ),
        ),
    
      ],
    );
  }
}//Utiltity Section