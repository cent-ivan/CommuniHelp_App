//Emergency Hotline Body
import 'package:communihelp_app/ViewModels/emergency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class MDRRMOButton extends StatefulWidget {
  final int numberOfContacts;
  final Color? color;
  const MDRRMOButton({super.key, required this.numberOfContacts, required this.color});

  @override
  State<MDRRMOButton> createState() => _MDRRMOButtonState();
}

class _MDRRMOButtonState extends State<MDRRMOButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (110 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: viewModel.mddrmoContacts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8).r,
              child: MaterialButton(
                  onPressed: () {
                  },
                  height: 100.r,
                  minWidth: 340.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r))
                  ),
                  color: widget.color,
                  splashColor: const Color(0x80FEAE49),
                  elevation: 0.r,
                  child: Row(
                    children: [
                      //TODO: Change image, number and name of hotline
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
                              viewModel.mddrmoContacts[index].number!, //gets the name from the list
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                        
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

class AmbulanceButton extends StatefulWidget {
  final int numberOfContacts;
  final Color? color;
  const AmbulanceButton({super.key, required this.numberOfContacts, required this.color});

  @override
  State<AmbulanceButton> createState() => _AmbulanceButtonState();
}

class _AmbulanceButtonState extends State<AmbulanceButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (110 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: widget.numberOfContacts,
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
                  color: widget.color,
                  splashColor: const Color(0x80FEAE49),
                  elevation: 0.r,
                  child: Row(
                    children: [
                      //TODO: Change image, number and name of hotline
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
                              viewModel.ambulanceContacts[index].number!, //gets the name from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                        
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


class BFPButton extends StatefulWidget {
  final int numberOfContacts;
  final Color? color;
  const BFPButton({super.key, required this.numberOfContacts, required this.color});

  @override
  State<BFPButton> createState() => _BFPButtonState();
}

class _BFPButtonState extends State<BFPButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (110 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: widget.numberOfContacts,
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
                  color: widget.color,
                  splashColor: const Color(0x80FEAE49),
                  elevation: 0.r,
                  child: Row(
                    children: [
                      //TODO: Change image, number and name of hotline
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
                              viewModel.bfpContacts[index].number!, //gets the name from the list
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                        
                            Text(
                              viewModel.bfpContacts[index].contactName!, //gets the name from the list
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
