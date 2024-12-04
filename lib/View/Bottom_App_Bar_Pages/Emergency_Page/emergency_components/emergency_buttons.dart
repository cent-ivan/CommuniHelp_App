//Emergency Hotline Body
import 'package:cached_network_image/cached_network_image.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/emergency_view_model.dart';
import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

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
  final DirectCaller directCaller = DirectCaller();
  String? slotIndex;

  final _simCardInfoPlugin = SimCardInfo();
  List<SimInfo>? _simCardInfo;
  bool isSupported = false;

  Logger logger = Logger(); //show message for debugging

  static final  customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );

  Future<void> initSimInfoState() async {
    await Permission.phone.request();
    List<SimInfo>? simCardInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      simCardInfo = await _simCardInfoPlugin.getSimInfo() ?? [];
    } on PlatformException {
      simCardInfo = [];
      setState(() {
        isSupported = false;
      });
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _simCardInfo = simCardInfo;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<GetUserData>(context);
    return Container(
      
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12).r,
      ),
      height: (220 ).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: viewModel.mddrmoContacts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10).r,
              child: MaterialButton(
                  onPressed: () async {

                    await initSimInfoState();
                    for (SimInfo info in _simCardInfo!) {
                      //checks if device's number is equal to the user's mobile number
                      if (info.number == userData.mobileNumber) {
                        slotIndex = info.slotIndex;
                      }
                    }

                    //check if slot is there
                    if (slotIndex != null) {
                      directCaller.makePhoneCall(viewModel.mddrmoContacts[index].number!, simSlot: int.parse(slotIndex!) + 1);
                      
                    }
                    else {
                      logger.e("Default");
                      await DirectCallPlus.makeCall(viewModel.mddrmoContacts[index].number!);
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
                      viewModel.mddrmoContacts[index].url!.isEmpty ?
                      Container( //shows when empty
                        padding: const EdgeInsets.fromLTRB(20, 0, 25, 0).r,
                        child: CircleAvatar(
                          radius: 45.r,
                          backgroundImage: AssetImage("assets/images/rescuer.png"),
                        ),
                      ) 
                      : 
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 25, 0).r,
                        child: CachedNetworkImage( //cache the picture
                          cacheManager: customCache,
                          key: UniqueKey(),
                          imageUrl: viewModel.mddrmoContacts[index].url!,
                          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 45.r,
                          )
                        ),
                      ) ,

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
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              viewModel.mddrmoContacts[index].telecom!, //gets the municipality from the list
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 10.r,
                              ),
                            ),

                            SizedBox(height: 10.r,),
                        
                            Text(
                              viewModel.mddrmoContacts[index].contactName!, //gets the name from the list
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 12.r,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.italic
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
  final DirectCaller directCaller = DirectCaller();
  String? slotIndex;

  final _simCardInfoPlugin = SimCardInfo();
  List<SimInfo>? _simCardInfo;
  bool isSupported = false;

  Logger logger = Logger(); //show message for debugging

  Future<void> initSimInfoState() async {
    await Permission.phone.request();
    List<SimInfo>? simCardInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      simCardInfo = await _simCardInfoPlugin.getSimInfo() ?? [];
    } on PlatformException {
      simCardInfo = [];
      setState(() {
        isSupported = false;
      });
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _simCardInfo = simCardInfo;
    });
  }

  static final  customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );

  

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<GetUserData>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12).r,
      ),
      height: (30 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: widget.numberOfContacts,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10).r,
              child: MaterialButton(
                  onPressed: () async {
                    await initSimInfoState();
                    for (SimInfo info in _simCardInfo!) {
                      //checks if device's number is equal to the user's mobile number
                      if (info.number == userData.mobileNumber) {
                        slotIndex = info.slotIndex;
                      }
                    }

                    //check if slot is there
                    if (slotIndex != null) {
                      directCaller.makePhoneCall(viewModel.mddrmoContacts[index].number!, simSlot: int.parse(slotIndex!) + 1);
                      
                    }
                    else {
                      logger.e("Default");
                      await DirectCallPlus.makeCall(viewModel.mddrmoContacts[index].number!);
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
                      viewModel.ambulanceContacts[index].url!.isEmpty ?
                      Container( //shows when empty
                        padding: const EdgeInsets.fromLTRB(20, 0, 25, 0).r,
                        child: CircleAvatar(
                          radius: 45.r,
                          backgroundImage: AssetImage("assets/images/medical_team.png"),
                        ),
                      ) 
                      : 
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 25, 0).r,
                        child: CachedNetworkImage( //cache the picture
                          cacheManager: customCache,
                          key: UniqueKey(),
                          imageUrl: viewModel.ambulanceContacts[index].url!,
                          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 45.r,
                          )
                        ),
                      ) ,

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
                              viewModel.ambulanceContacts[index].telecom!, //gets the municipality from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 10.r,
                              ),
                            ),

                            SizedBox(height: 10.r,),
                        
                            Text(
                              viewModel.ambulanceContacts[index].contactName!, //gets the name from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 12.r,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.italic
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
  final DirectCaller directCaller = DirectCaller();
  String? slotIndex;

  final _simCardInfoPlugin = SimCardInfo();
  List<SimInfo>? _simCardInfo;
  bool isSupported = false;

  Logger logger = Logger(); //show message for debugging

  Future<void> initSimInfoState() async {
    await Permission.phone.request();
    List<SimInfo>? simCardInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      simCardInfo = await _simCardInfoPlugin.getSimInfo() ?? [];
    } on PlatformException {
      simCardInfo = [];
      setState(() {
        isSupported = false;
      });
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _simCardInfo = simCardInfo;
    });
  }

  static final  customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<GetUserData>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12).r,
      ),
      height: (120 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: widget.numberOfContacts,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8).r,
              child: MaterialButton(
                  onPressed: () async {
                    await initSimInfoState();
                    for (SimInfo info in _simCardInfo!) {
                      //checks if device's number is equal to the user's mobile number
                      if (info.number == userData.mobileNumber) {
                        slotIndex = info.slotIndex;
                      }
                    }

                    //check if slot is there
                    if (slotIndex != null) {
                      directCaller.makePhoneCall(viewModel.bfpContacts[index].number!, simSlot: int.parse(slotIndex!) + 1);
                      
                    }
                    else {
                      logger.e("Default");
                      await DirectCallPlus.makeCall(viewModel.bfpContacts[index].number!);
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
                      viewModel.bfpContacts[index].url!.isEmpty ?
                      Container( //shows when empty
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0).r,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage("assets/images/firefighter.png"),
                        ),
                      ) 
                      : 
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 25, 0).r,
                        child: CachedNetworkImage( //cache the picture
                          cacheManager: customCache,
                          key: UniqueKey(),
                          imageUrl: viewModel.bfpContacts[index].url!,
                          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 45.r,
                          )
                        ),
                      ) ,

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
                              viewModel.bfpContacts[index].telecom!, //gets the municipality from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 10.r,
                              ),
                            ),

                            SizedBox(height: 10.r,),
                        
                            Text(
                              viewModel.bfpContacts[index].contactName!, //gets the name from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 12.r,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.italic
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
  final DirectCaller directCaller = DirectCaller();
  String? slotIndex;

  final _simCardInfoPlugin = SimCardInfo();
  List<SimInfo>? _simCardInfo;
  bool isSupported = false;

  Logger logger = Logger(); //show message for debugging

  Future<void> initSimInfoState() async {
    await Permission.phone.request();
    List<SimInfo>? simCardInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      simCardInfo = await _simCardInfoPlugin.getSimInfo() ?? [];
    } on PlatformException {
      simCardInfo = [];
      setState(() {
        isSupported = false;
      });
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _simCardInfo = simCardInfo;
    });
  }

  static final  customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<GetUserData>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12).r,
      ),
      height: (120 * widget.numberOfContacts.toDouble()).r,
      child: Consumer<EmergencyViewModel>(builder: (context, viewModel, child) => ListView.builder(
          itemCount: widget.numberOfContacts,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8).r,
              child: MaterialButton(
                  onPressed: () async {
                    await initSimInfoState();
                    for (SimInfo info in _simCardInfo!) {
                      //checks if device's number is equal to the user's mobile number
                      if (info.number == userData.mobileNumber) {
                        slotIndex = info.slotIndex;
                      }
                    }

                    //check if slot is there
                    if (slotIndex != null) {
                      directCaller.makePhoneCall(viewModel.cgContacts[index].number!, simSlot: int.parse(slotIndex!) + 1);
                      
                    }
                    else {
                      logger.e("Default");
                      await DirectCallPlus.makeCall(viewModel.cgContacts[index].number!);
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
                      viewModel.cgContacts[index].url!.isEmpty ?
                      Container( //shows when empty
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0).r,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage("assets/images/rescuer.png"),
                        ),
                      ) 
                      : 
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 25, 0).r,
                        child: CachedNetworkImage( //cache the picture
                          cacheManager: customCache,
                          key: UniqueKey(),
                          imageUrl: viewModel.cgContacts[index].url!,
                          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 45.r,
                          )
                        ),
                      ) ,

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
                              viewModel.cgContacts[index].telecom!, //gets the municipality from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 10.r,
                              ),
                            ),

                            SizedBox(height: 10.r,),
                        
                            Text(
                              viewModel.cgContacts[index].contactName!, //gets the name from the list
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 12.r,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.italic
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