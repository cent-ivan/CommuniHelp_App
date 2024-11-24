import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Model/evacuation_marker_model.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/ViewModel/Evacuation_Finder_View_Models/direction_repo.dart';
import 'package:communihelp_app/ViewModel/Evacuation_Finder_View_Models/evacuation_finder_view_model.dart';
import 'package:communihelp_app/auth_director.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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

  

  final vModel = EvacuationFinderViewModel();
  final userData = GetUserData();

  GoogleMapController? googleMapController;

  //gets teh current location
  LocationData? currentLocation;

  Set<Marker> evacPins = {}; //store from firestore to set
  Map<String, dynamic> evacData = {}; //Temp store data of evac positions

  @override
  void initState() {
    vModel.setCustomMarker();
    vModel.userCustomMarker(userData);
    getCurrentLocation();
    loadPins();
    super.initState();
  }

  @override
  void dispose() {
    if (googleMapController != null) {
      googleMapController?.dispose();
    }
    super.dispose();
  }

  void loadPins() {
    setState(() {
      evacPins.clear();
      getMarkers(userData.municipality);
    });
    
    
  }

  
  String? deleteValue;
  
  static final  customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );
  

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EvacuationFinderViewModel>(context);
    final director = Provider.of<Director>(context);
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MapAppBar(),

      body: 
      currentLocation == null ?
      Center(child: CircularProgressIndicator(color: Color(0xA6FEAE49),),) :
      Stack(
        children: [
          //MAP DISPLAY
          GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!), zoom: 12.5), //CameraPosition(target: LatLng(viewModel.currentLocation!.latitude!, viewModel.currentLocation!.longitude!), zoom: 14.5), //set initial position when opened
            onMapCreated: (controller) => googleMapController = controller, //assign the controller
            markers: {
              viewModel.origin ?? Marker( markerId: const MarkerId('origin')), //applies temporary value, reserve
              viewModel.destination ??  Marker( markerId: const MarkerId('destination')),
              viewModel.placedPin ?? Marker( markerId: const MarkerId('temp_marker')),

              //current position pin
              Marker(
                markerId: MarkerId('user_position'),
                position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                infoWindow: InfoWindow(title: "You"),
                icon: vModel.userMarker,
                flat: true
              ),


            }.union(evacPins), //ADD ALL OF THE MARKERS IN THE DATABASE

            onLongPress: (pos) {
              !viewModel.pinMode ? addMarker(pos, viewModel) : null;
            },
            onTap: (pos) {
              viewModel.pinMode ? addEvac(pos, viewModel) : null;
            },

            //lines
            polylines: {
              //draws polyline or route
              if (viewModel.direct != null)
              Polyline(
                polylineId: PolylineId('route_polyline'),
                startCap: Cap.roundCap,
                endCap: Cap.roundCap,
                color: Color(0xA6FEAE49),
                width: 6,
                points: viewModel.direct!.polylinePoints.map(
                  (e) => LatLng(e.latitude, e.longitude)).toList(),
                
              )
            },
          ),

          //select mode
          if (!viewModel.pinMode)
          Positioned(
            bottom: 90.r,
            left: 10.r,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 8.r),
              decoration: BoxDecoration(
                color: Color(0xCCF2F2F2), //button
                borderRadius: BorderRadius.circular(4).r
              ),
              child: Row(
                children: [
                  Text(
                    'Mode: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.r,
                      
                    ),
                  ),

                  DropdownButton(
                    value: viewModel.mode,
                    dropdownColor: Color(0xFFEDEDED),
                      underline: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    iconEnabledColor: Colors.black,
                    items: [
                      DropdownMenuItem(
                        value: 'walking',
                        child: Text(
                            'Walking',
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.r,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'driving',
                        child: Text(
                            'Driving',
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.r,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'bicycling',
                        child: Text(
                            'Bicycling',
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.r,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ], 
                    onChanged: (newValue) async {
                      viewModel.mode = newValue!;
                      if (viewModel.targetEvac != null && viewModel.destination == null) {
                        //if user picked a evacuation
                        final directions  = await DirectionRepo().getDirection(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), getEvacPosition(viewModel.targetEvac!), viewModel.mode);
                        setState(() {
                          viewModel.direct = directions;
                        });
                      }
                      //if have pins
                      else if (viewModel.origin?.position != null && viewModel.destination?.position != null) {
                        final directions = await DirectionRepo().getDirection(viewModel.origin!.position, viewModel.destination!.position, viewModel.mode);
                        setState(() {
                          viewModel.direct = directions;
                        });
                      }
                      else {
                        logger.e("Nuttun");
                      }
                      
                      
                    }
                  ),

                ],
              ),
            )
          ),


          if (viewModel.direct != null) 
          //shows text info about distance and duration when showing a navigation polyline
          Positioned(
            top:  20.r,
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


          if (viewModel.pinMode)
          //exit pin mode
          Positioned(
            bottom: 15.r,
            left: 15.r,
            child: MaterialButton(
              color: Color(0xFFFEA332),
              onPressed: () {
                setState(() {
                  viewModel.pinMode = false;
                  viewModel.placedPin = null;
                });
                
              },
              child: Text(
                "Exit Pin Mode",
                style: TextStyle(
                  fontSize: 12.r,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),

          //evac picture
          if (viewModel.targetEvac != null && !viewModel.pinMode)
          Positioned(
            bottom: 155.r,
            left: 10.r,
            child: viewModel.imageurl! != "" ? GestureDetector(
              onTap: () {
                showImage(context, viewModel.targetEvac!, viewModel);
              },
              child: Container(
                width: 125.r,
                height: 125.r,
                padding: EdgeInsets.all(8).r,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(4).r
                ),
                child: CachedNetworkImage(
                  cacheManager: customCache,
                  key: UniqueKey(),
                  imageUrl: viewModel.imageurl!,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Image.asset('assets/images/default_image.png', height: 150, width: 150,),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 135.r,
                    height: 160.r,
                    padding: EdgeInsets.all(8).r,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(5).r
                    ),
                  ),
                ),
              ),
            ) :
            Container(
              width: 115.r,
              height: 115.r,
              padding: EdgeInsets.all(8).r,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/dashboard/checklist_images/no_pictures.png'), fit: BoxFit.fill),
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(4).r
              ),
                
            ),
          ),
          
          

          if (!viewModel.pinMode)
          //DROPDWON
          Positioned(
            bottom: 10.r,
            left: 10.r,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.r, horizontal: 4.r),
              decoration: BoxDecoration(
                color: Color(0xCCF2F2F2), //button
                borderRadius: BorderRadius.circular(4).r
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

                  //get from firestore
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
                        value: viewModel.initialValue,
                        dropdownColor: Color(0xFFEDEDED),
                        underline: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        iconEnabledColor: Colors.black,
                        onChanged: (newVal) {
                          setState(() {
                            viewModel.direct = null;
                            // Get the document data
                            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                            viewModel.initialValue= newVal;
                            viewModel.targetEvac = newVal;
                            viewModel.imageurl = data[newVal]['image'];
                            
                          });
                          googleMapController?.animateCamera(
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
      
          
          if (!viewModel.pinMode)
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
                  label: "CLEAR",
                  onTap: () {
                    viewModel.clearMyPins();
                  }
                ),
                SpeedDialChild(
                  labelBackgroundColor: Color(0xFFFEA339),
                  label: "Path to evacuate",
                  //for direction
                  onTap: () async { // origin to target

                    if (viewModel.targetEvac != null) {
                      final directions  = await DirectionRepo().getDirection(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), getEvacPosition(viewModel.targetEvac!), viewModel.mode);
                      setState(() {
                        viewModel.direct = directions;
                      });
                    }
                    else {
                      dialog.noLocationDialog(context);
                    }
                    
                  }
                ),
                
                //delete pin
                if(director.isResponder)
                SpeedDialChild(
                  labelBackgroundColor: Colors.redAccent,
                  label: "DELETE a Pin",
                  onTap: () {
                    viewModel.initialValue = null;
                    deleteEvac(viewModel);
                  }
                ),

                //create pin
                if(director.isResponder)
                SpeedDialChild(
                  labelBackgroundColor: Colors.greenAccent,
                  label: "NEW Evacuation Pin",
                  onTap: () {
                    viewModel.pinMode = true;
                    viewModel.origin = null;
                    viewModel.destination = null;
                    viewModel.direct = null;
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
          backgroundColor: Color(0xFF2BADDF),
          foregroundColor: Color(0xFFCC0000),
          onPressed: () => googleMapController?.animateCamera(
            viewModel.direct != null ? 
            CameraUpdate.newLatLngBounds(viewModel.direct!.bounds, 100.0) :
            CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!), zoom: 12.5, tilt: 30.0),) //move to initial position,
          ),
          child: viewModel.direct == null? Icon(Icons.pin_drop)  : Icon(Icons.center_focus_strong),
        ),
      ),

    );
  }

  
  //METHODS--------------------------------------------------------
  //adds blue and gree pin in the map
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
          onTap: () => googleMapController?.animateCamera(
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
          onTap: () => googleMapController?.animateCamera(
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

      final directions = await DirectionRepo().getDirection(viewModel.origin!.position, viewModel.destination!.position, viewModel.mode);
      setState(() {
        viewModel.direct = directions;
      });
      
    }
  }

  //gets the user current location
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

  //gets the position of the evacuation when changed in the 
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

  //loads all the evac pins in the firestore
  Future getMarkers(String municipality) async {
   
    try {
      //This line will retrieve the markers position
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

  //RESPONDER PIN Mode
  void addEvac(LatLng pos, EvacuationFinderViewModel viewModel) async {
    //add maker of ORIGIN, if origin is not set OR both origin and destination are set
    if (viewModel.pinMode) {
      //assign variable at _origin
      viewModel.placedPin = null;
      setState(() {
        viewModel.placedPin = Marker(
          markerId: const MarkerId('temp_marker'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          position: pos,
          onTap: () {
            googleMapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: pos,
                  zoom: 13.5,
                )
              )
            );
            viewModel.assignEvacPos(pos);
            Navigator.pushNamed(context, '/addmarkerpage');
          }
        );
       
      });
    }
    
  }

  void deleteEvac(EvacuationFinderViewModel viewModel) {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) {
        return SimpleDialog(
          backgroundColor: const Color(0xF2FCFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.r),)
          ),
          contentPadding: EdgeInsets.all(16).r,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delete a pin",
                    style: TextStyle(
                      color:  Color(0xFF3D424A),
                      fontSize: 16.r,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  //exit
                  IconButton(
                    onPressed: () {
                      setState(() {
                        
                      });
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.exit_to_app, color: Color(0xFF3D424A),),
                  )
                  
                ],
            ),

            SizedBox(
              child: 
                //get from firestore DROPDWON for delete
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
                        value: deleteValue,
                        dropdownColor: Color(0xFFEDEDED),
                        underline: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        iconEnabledColor: Colors.black,
                        onChanged: (newVal) {
                          setState(() {
                            evacData.remove(newVal);
                            deleteValue= newVal;
                            viewModel.clearMyPins();
                          });

                          Navigator.pop(context);
                          deleteEvac(viewModel); //returns to dialog to refresh  
                        },
                        items: evacPlace,
                      );
                    }
                  ),

            ),

            //delete button
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                //sends pos to firestore
                viewModel.deleteEvacPin(deleteValue!, userData.municipality);
                deleteValue = null;
                setState(() {
                  loadPins();
                  viewModel.destination = null;
                });    
                
                Navigator.pop(context);
              },
              child: Text("DELETE", style: TextStyle(color: Color(0xFF3D424A), fontWeight: FontWeight.bold),),
            ),
          ],
        );
      }
    );
  }

  
  //show picture
  void showImage(BuildContext context, String evacKey, EvacuationFinderViewModel viewModel) {
    showDialog(
      context: context, 
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.r),)
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          children: [
            CachedNetworkImage(
              cacheManager: customCache,
              key: UniqueKey(),
              imageUrl: viewModel.imageurl!,
              progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => Image.asset('assets/images/dashboard/checklist_images/no_pictures.png', height: 150, width: 150,),
              imageBuilder: (context, imageProvider) => Container(
                width: 145.r,
                height: 150.r,
                padding: EdgeInsets.all(8).r,
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                  borderRadius: BorderRadius.circular(5).r
                ),
              ),
            ),
          
          ],
        );
      }
    );
  }
}

  

//APP BAR-------------------------------------------------------
class MapAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MapAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EvacuationFinderViewModel>(context);
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
          viewModel.pinMode = false;
          viewModel.placedPin = null;
          viewModel.clearMyPins();
          viewModel.mode = "walking";
          viewModel.initialValue = null;
          viewModel.targetEvac = null;
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}