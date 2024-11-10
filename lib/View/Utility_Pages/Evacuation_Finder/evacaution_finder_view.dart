import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Model/evacuation_marker_model.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/ViewModel/Evacuation_Finder_View_Models/direction_repo.dart';
import 'package:communihelp_app/ViewModel/Evacuation_Finder_View_Models/evacuation_finder_view_model.dart';
import 'package:communihelp_app/auth_director.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class EvacautionFinderView extends StatefulWidget {
  const EvacautionFinderView({super.key});

  @override
  State<EvacautionFinderView> createState() => _EvacautionFinderViewState();
}

class _EvacautionFinderViewState extends State<EvacautionFinderView> {
  Logger logger = Logger(); //for debug messages
  final dialog = GlobalDialogUtil();
  final director = Director();
  

  final vModel = EvacuationFinderViewModel();
  final userData = GetUserData();

  late GoogleMapController googleMapController;

  //gets teh current location
  LocationData? currentLocation;

  @override
  void initState() {
    vModel.setCustomMarker();
    getCurrentLocation();
    loadPins();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  void loadPins() {
    getMarkers(userData.municipality);
    
  }

  String? initialValue;
  String? targetEvac;
  
  Set<Marker> evacPins = {}; //store from firestore to set
  //Temp store data of evac positions
  Map<String, dynamic> evacData = {};

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EvacuationFinderViewModel>(context);
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MapAppBar(),

      body: 
      currentLocation == null ?
      Center(child: CircularProgressIndicator(color: Color(0xA6FEAE49),),) :
      Stack(
        children: [
          //Map
          GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!), zoom: 12.5), //CameraPosition(target: LatLng(viewModel.currentLocation!.latitude!, viewModel.currentLocation!.longitude!), zoom: 14.5), //set initial position when opened
            onMapCreated: (controller) => googleMapController = controller, //assign the controller
            markers: {
              viewModel.origin ?? Marker( markerId: const MarkerId('origin')), //applies temporary value,
              viewModel.destination ??  Marker( markerId: const MarkerId('destination')),

              //current positioni pin
              Marker(
                markerId: MarkerId('user_position'),
                position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                infoWindow: InfoWindow(title: "You"),
              )

            }.union(evacPins),

            onLongPress: (pos) {
              addMarker(pos, viewModel);
            },

            //lines
            polylines: {
              //draws polyline
              if (viewModel.direct != null)
              Polyline(
                polylineId: PolylineId('sample_polyline'),
                startCap: Cap.roundCap,
                endCap: Cap.roundCap,
                color: Color(0xA6FEAE49),
                width: 6,
                points: viewModel.direct!.polylinePoints.map(
                  (e) => LatLng(e.latitude, e.longitude)).toList(),
                
              )
            },
          ),

          Positioned(
            bottom: 10.r,
            left: 10.r,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.r, horizontal: 4.r),
              decoration: BoxDecoration(
                color: Color(0x73F2F2F2), //button
                borderRadius: BorderRadius.circular(5).r
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Evacuation Center List",
                    style: TextStyle(
                        fontSize: 12.r,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),


                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('locations_evac').doc(userData.municipality.toUpperCase()).snapshots(), 
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("some error occured ${snapshot.error}"),);
                      }

                      List<DropdownMenuItem> evacPlace = [];
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.exists) {
                        // Get the document data
                        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        
                        for (String key in data.keys) {
                          evacPlace.add(
                            DropdownMenuItem(
                              value: key,
                              child: Text(
                                  data[key]["name"],
                                  style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.r
                                ),
                              ),
                            )
                          );
                        }
                      }

                      return DropdownButton(
                        value: initialValue,
                        dropdownColor: Color(0xFFEDEDED),
                        underline: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        iconEnabledColor: Colors.black,
                        onChanged: (newVal) {
                          setState(() {
                            initialValue= newVal;
                            targetEvac = newVal;
                          });
                          googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: getEvacPosition(newVal),
                                zoom: 15.5,
                                tilt: 50.0
                              )
                            )
                          );
                        },
                        onTap: () {
                          getMarkers(userData.municipality);
                        },
                        items: evacPlace,
                      );
                    }
                  ),

                  
                  
                ],
              ),
            ),
          ),
      
          if (viewModel.direct != null) 
          //shows text info about distance and duration
          Positioned(
            top: 20.r,
            right: 10.r,
            child: Container(
              height: 35.r,
              padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 12.r),
              decoration: BoxDecoration(
                color: Color(0xFFADADAD),
                borderRadius: BorderRadius.circular(3.5).r,
                gradient: LinearGradient(
                  colors: [const Color(0xFFFEAE49), const Color(0xCCFEC57C), Color(0xFFEEEDAD), ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.decal
                ),
              ),
              child: Text(
                "DISTANCE: ${viewModel.direct!.totalDistance}",
                style: TextStyle(
                  fontSize: 13.r,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),
          ),

          //Features dial
          Positioned(
            bottom: 85.r,
            right: 15.r,
            child: SpeedDial(
              elevation : 0,
              backgroundColor: Color(0xFF57BEE6),
              overlayColor: Colors.black26,
              animatedIcon: AnimatedIcons.list_view,
              children: [
                SpeedDialChild(
                  labelBackgroundColor: Colors.redAccent,
                  label: "Clear my pins",
                  onTap: () {
                    viewModel.clearMyPins();
                  }
                ),
                SpeedDialChild(
                  labelBackgroundColor: Color(0xFFFEAE49),
                  label: "Path to evacuate",
                  //for direction
                  onTap: () async { // origin to target

                    if (targetEvac != null) {
                      final directions  = await DirectionRepo().getDirection(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), getEvacPosition(targetEvac!));
                      setState(() {
                        viewModel.direct = directions;
                      });
                    }
                    else {
                      dialog.noLocationDialog(context);
                    }
                    
                  }
                ),
      
              ],
            ),
          )
        ],
      ),

      floatingActionButton: SizedBox.fromSize(
        size: Size.square(50.r),
        child: FloatingActionButton(
          heroTag: 'mapFocusHero',
          elevation: 0,
          backgroundColor: Color(0xFF57BEE6),
          foregroundColor: Colors.black,
          onPressed: () => googleMapController.animateCamera(
            viewModel.direct != null ? 
            CameraUpdate.newLatLngBounds(viewModel.direct!.bounds, 100.0) :
            CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!), zoom: 12.5, tilt: 20.0),) //move to initial position,
          ),
          child: viewModel.direct == null? Icon(Icons.pin_drop)  : Icon(Icons.center_focus_strong),
        ),
      ),

    );
  }

  

  void getCurrentLocation() async {
    Location location = Location();
    try {
      await location.getLocation().then((location) {
      if (mounted) {
          setState(() {
          currentLocation = location;
        });
      }
      });

      //listens to movement of user
      location.onLocationChanged.listen(
        (newLoc) {
          
          if (mounted) {
            setState(() {
              //assigns nwe location
              currentLocation = newLoc;
            });
          }
        }
      );
    } catch (e) {
      logger.e("Error: ${e.toString()}");
    }
    

    logger.i("Added current location: $currentLocation");
  }

  //gets the position of
  LatLng getEvacPosition(String id) {
    LatLng postion;
    if (evacData.containsKey(id) && evacData.isNotEmpty) {
      postion = evacData[id];
    }
    else {
      postion = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    }
    return postion;
  }

  //returns epins
  Future getMarkers(String municipality) async {
   
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("locations_evac").doc(municipality.toUpperCase()).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        for (String key in data.keys) {
          EvacuationMarkerModel markerData =  EvacuationMarkerModel.fromJson(data[key]);
          logger.i(key);
          //Store at temp map
          evacData[key] = markerData.position;

          //adds it to the list of pins
          evacPins.add(
            Marker(
              markerId: MarkerId(key),
              infoWindow: InfoWindow(title: markerData.name),
              position: markerData.position!,
              icon: vModel.evacIcon,
            )
          );
        }

      }
    }
    catch (error) {
      logger.e("Error: ${error.toString()}");
    }
  }

  //adds pin 
  void addMarker(LatLng pos, EvacuationFinderViewModel viewModel) async {
    //add maker of ORIGIN, if origin is not set OR both origin and destination are set
    if (viewModel.origin == null || (viewModel.origin != null && viewModel.destination != null) ) {
      //assign variable at _origin
      setState(() {
        viewModel.direct = null; //clears the polyline if one pin
        viewModel.origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: InfoWindow(title: 'Origin ${pos.toString()}'), //display text over the marker
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: pos,
          onTap: () => googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: pos,
                zoom: 17.5,
                tilt: 50.0
              )
            )
          )
        );

        viewModel.destination = null;
        
      });
    }
    else {
      //add marker for destination
      setState(() {
        viewModel.destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: InfoWindow(title: 'Destination ${pos.toString()}'), //display text over the marker
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
          onTap: () => googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: pos,
                zoom: 17.5,
                tilt: 50.0
              )
            )
          )
        );
      });

      final directions = await DirectionRepo().getDirection(viewModel.origin!.position, viewModel.destination!.position);
      setState(() {
        viewModel.direct = directions;
      });
      
    }
  }
}

  

//APP BAR-------------------------------------------------------
class MapAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MapAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
          "Evacuation Map",
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
          
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}