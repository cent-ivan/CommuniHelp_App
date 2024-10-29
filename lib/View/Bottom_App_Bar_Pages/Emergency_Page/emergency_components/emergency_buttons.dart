//Emergency Hotline Body
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/emergency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//LDDRMO BUTTON
class LDRRMOButton extends StatefulWidget {
  final int numberOfContacts;
  final Color? color;
  const LDRRMOButton({super.key, required this.numberOfContacts, required this.color});

  @override
  State<LDRRMOButton> createState() => _LDRRMOButtonState();
}

class _LDRRMOButtonState extends State<LDRRMOButton> {
  //access dialogs
  GlobalDialogUtil dialogs = GlobalDialogUtil();

  Logger logger = Logger(); //show message for debugging

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (100 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: viewModel.mddrmoContacts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10).r,
              child: MaterialButton(
                  onPressed: () async {
                    //uri path to paste in phone call
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: viewModel.mddrmoContacts[index].number!
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                    else {
                      if (context.mounted) {
                        dialogs.unknownErrorDialog(context, "Cannot be launched");
                      }
                      else {
                        logger.e("Cannot be launch");
                      }
                    }
                    
                  },
                  height: 115.r,
                  minWidth: 190.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r))
                  ),
                  color: widget.color,
                  splashColor: const Color(0x80FEAE49),
                  elevation: 0.r,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0).r,
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
                              viewModel.mddrmoContacts[index].number!, //gets the number from the list
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                            Text(
                              viewModel.mddrmoContacts[index].municipality!, //gets the municipality from the list
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 12.r,
                              ),
                            ),

                            SizedBox(height: 10.r,),
                        
                            Text(
                              viewModel.mddrmoContacts[index].contactName!, //gets the name from the list
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

        )
      ),
    );
  }
}

//AMBULANCE BUTTON
class AmbulanceButton extends StatefulWidget {
  final int numberOfContacts;
  final Color? color;
  const AmbulanceButton({super.key, required this.numberOfContacts, required this.color});

  @override
  State<AmbulanceButton> createState() => _AmbulanceButtonState();
}

class _AmbulanceButtonState extends State<AmbulanceButton> {
  //access dialogs
  GlobalDialogUtil dialogs = GlobalDialogUtil();

  Logger logger = Logger(); //show message for debugging

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (85 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: widget.numberOfContacts,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10).r,
              child: MaterialButton(
                  onPressed: () async {
                    //uri path to paste in phone call
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: viewModel.ambulanceContacts[index].number!
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                    else {
                      if (context.mounted) {
                        dialogs.unknownErrorDialog(context, "Cannot be launched");
                      }
                      else {
                        logger.e("Cannot be launch");
                      }
                    }
                  },
                  height: 115.r,
                  minWidth: 190.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r))
                  ),
                  color: widget.color,
                  splashColor: const Color(0x80FEAE49),
                  elevation: 0.r,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0).r,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: const AssetImage('assets/images/medical_team.png'),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.ambulanceContacts[index].number!, //gets the number from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                            Text(
                              viewModel.ambulanceContacts[index].municipality!, //gets the municipality from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 12.r,
                              ),
                            ),

                            SizedBox(height: 10.r,),
                        
                            Text(
                              viewModel.ambulanceContacts[index].contactName!, //gets the name from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
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

        )
      ),
    );
  }
}


//BFP BUTTON
class BFPButton extends StatefulWidget {
  final int numberOfContacts;
  final Color? color;
  const BFPButton({super.key, required this.numberOfContacts, required this.color});

  @override
  State<BFPButton> createState() => _BFPButtonState();
}

class _BFPButtonState extends State<BFPButton> {
  //access dialogs
  GlobalDialogUtil dialogs = GlobalDialogUtil();

  Logger logger = Logger(); //show message for debugging

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (120 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: widget.numberOfContacts,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8).r,
              child: MaterialButton(
                  onPressed: () async {
                    //uri path to paste in phone call
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: viewModel.bfpContacts[index].number!,
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                    else {
                      if (context.mounted) {
                        dialogs.unknownErrorDialog(context, "Cannot be launched");
                      }
                      else {
                        logger.e("Cannot be launch");
                      }
                    }
                  },
                  height: 115.r,
                  minWidth: 190.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r))
                  ),
                  color: widget.color,
                  splashColor: const Color(0x80FEAE49),
                  elevation: 0.r,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0).r,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: const AssetImage('assets/images/firefighter.png'),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.bfpContacts[index].number!, //gets the contact from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                            Text(
                              viewModel.mddrmoContacts[index].municipality!, //gets the municipality from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 12.r,
                              ),
                            ),

                            SizedBox(height: 10.r,),
                        
                            Text(
                              viewModel.bfpContacts[index].contactName!, //gets the name from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
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

        )
      ),
    );
  }
}


//COAST GUARD BUTTON
class CoastButton extends StatefulWidget {
  final int numberOfContacts;
  final Color? color;
  const CoastButton({super.key, required this.numberOfContacts, required this.color});

  @override
  State<CoastButton> createState() => _CoastButtonState();
}

class _CoastButtonState extends State<CoastButton> {
  //access dialogs
  GlobalDialogUtil dialogs = GlobalDialogUtil();

  Logger logger = Logger(); //show message for debugging

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (120 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: widget.numberOfContacts,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8).r,
              child: MaterialButton(
                  onPressed: () async {
                    //uri path to paste in phone call
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: viewModel.cgContacts[index].number!,
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                    else {
                      if (context.mounted) {
                        dialogs.unknownErrorDialog(context, "Cannot be launched");
                      }
                      else {
                        logger.e("Cannot be launch");
                      }
                    }
                  },
                  height: 115.r,
                  minWidth: 190.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r))
                  ),
                  color: widget.color,
                  splashColor: const Color(0x80FEAE49),
                  elevation: 0.r,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0).r,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: const AssetImage('assets/images/firefighter.png'),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.cgContacts[index].number!, //gets the contact from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                            Text(
                              viewModel.cgContacts[index].municipality!, //gets the municipality from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 12.r,
                              ),
                            ),

                            SizedBox(height: 10.r,),
                        
                            Text(
                              viewModel.cgContacts[index].contactName!, //gets the name from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
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

        )
      ),
    );
  }
}