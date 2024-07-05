//Emergency Hotline Body
import 'package:communihelp_app/Views/Bottom_App_Bar_Pages/Emergency_Page/emergency_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmergencyNumbers extends StatelessWidget {
  const EmergencyNumbers({
    super.key,
    required this.numberOfMDRRMO,
    required this.numberOfAmbulance,
    required this.numberOfPolice,
  });

  final int numberOfMDRRMO;
  final int numberOfAmbulance;
  final int numberOfPolice;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(13).r,
        child: Container(
          height: (700 + (numberOfMDRRMO.toDouble() * 5) * ((numberOfAmbulance.toDouble() * 5) + (numberOfPolice.toDouble() * 10))).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              //Municipality Tag
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.all(Radius.circular(15.r))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10).r,
                  child: Text(
                    "<Municipality here>",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 16.r,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
                  
                  
              SizedBox(height: 15.r,),
    
              //MDDRMO Title
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(9, 25, 9, 10).r,
                      child: Text(
                        "MDDRMO Rescuers",
                        style: TextStyle(
                          fontSize: 20.r,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.outline, 
                        ),
                      ),
                    ),
                        
                    //MDRRMO Number
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: EmergencyContacts(numberOfContacts: numberOfMDRRMO,color: const Color(0x4DFEAE49),)
                    ),
                  ],
                ),
              ),
                  
                  
              //Ambulance Title
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(9, 25, 9, 10).r,
                child: Text(
                  "Numero it Ambulansya",
                  style: TextStyle(
                    fontSize: 20.r,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline, 
                  ),
                ),
              ),
                  
              //Ambulance number
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: EmergencyContacts(numberOfContacts: numberOfAmbulance, color: Theme.of(context).colorScheme.primary, )
              ),
    

              SizedBox(height: 10.r,),
                  
              //Police Title
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(9, 25, 9, 10).r,
                child: Text(
                  "Numero it Pulisya",
                  style: TextStyle(
                    fontSize: 20.r,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline, 
                  ),
                ),
              ),
                  
              //Police number
              ClipRRect(
                borderRadius: BorderRadius.circular(15).r,
                child: EmergencyContacts(numberOfContacts: numberOfPolice, color: const Color(0x4D57BEE6), )
              ),
    
            ],
          ),
        ),
      ),
    );
  }
}
