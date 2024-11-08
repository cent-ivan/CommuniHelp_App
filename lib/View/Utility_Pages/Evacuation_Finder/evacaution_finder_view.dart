import 'package:communihelp_app/ViewModel/Evacuation_Finder_View_Models/direction_repo.dart';
import 'package:communihelp_app/ViewModel/Evacuation_Finder_View_Models/evacuation_finder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class EvacautionFinderView extends StatefulWidget {
  const EvacautionFinderView({super.key});

  @override
  State<EvacautionFinderView> createState() => _EvacautionFinderViewState();
}

class _EvacautionFinderViewState extends State<EvacautionFinderView> {
  Logger logger = Logger(); //for debug messages
  
  //sets the initial focus of the camera when the map is created
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(11.904964, 122.000402), //TODO: change this to municipal LatLng
    zoom: 17 //lower the zoom out it gets
  );

  final LatLng evacPosition = LatLng(11.906098, 122.00043);

  final vModel = EvacuationFinderViewModel();

  late GoogleMapController googleMapController;

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EvacuationFinderViewModel>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MapAppBar(),

      body: Stack(
        children: [
          
          //Map
          GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition, //set initial position when opened
            onMapCreated: (controller) => googleMapController = controller, //assign the controller
            markers: {
               viewModel.origin ?? Marker( markerId: const MarkerId('origin')), //applies temporary value,
              viewModel.destination ??  Marker( markerId: const MarkerId('destination')),
      
              //sample evac center
              Marker(
                markerId: const MarkerId('evac_center'),
                infoWindow: InfoWindow(title: 'Unidos Evac location'), //display text over the marker
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                position: evacPosition,
                onTap: () => googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: evacPosition,
                      zoom: 19.5,
                      tilt: 40.0
                    )
                  )
                )
      
              )
            },
            onLongPress: (pos) {
              addMarker(pos, viewModel);
            },
            polylines: {
              if (viewModel.direct != null)
              Polyline(
                polylineId: PolylineId('sample_polyline'),
                color: Colors.amber,
                width: 5,
                points: viewModel.direct!.polylinePoints.map(
                  (e) => LatLng(e.latitude, e.longitude)).toList(),
                
              )
            },
          ),

          Positioned(
            bottom: 20.r,
            left: 10.r,
            child: Container(
              padding: EdgeInsets.all(4).r,
              decoration: BoxDecoration(
                color: Color(0xE657BEE6),
                borderRadius: BorderRadius.circular(6).r
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Evacuation Center List",
                    style: TextStyle(
                        fontSize: 14.r,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),

                  DropdownButton(
                    value: "NABAS_hds",
                    dropdownColor: Color(0xFFEDEDED),
                    underline: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    iconEnabledColor: Colors.black,
                    onChanged: (newVal) {

                    },
                    items: [
                      DropdownMenuItem(
                        value: 'NABAS_unidos',
                        child: Text(
                          "Unidos Multi-Purpose Pavement",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.r
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'NABAS_Evac',
                        child: Text(
                          "Nabas Multi-Purpose Pavement",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.r
                          ),
                        ),
                      ),
                    ], 
                  )
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
                borderRadius: BorderRadius.circular(4).r,
                gradient: LinearGradient(
                  colors: [const Color(0xFFFEAE49), const Color(0xCCFEC57C), Color(0xFFEEEDAD), ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.decal
                ),
              ),
              child: Text(
                "DISTANCE: ${viewModel.direct!.totalDistance}, ${viewModel.direct!.totalDuration}",
                style: TextStyle(
                  fontSize: 13.r,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),
          ),
      
      
          Positioned(
            bottom: 85,
            right: 15,
            child: SpeedDial(
              elevation : 0,
              backgroundColor: Color(0xFF57BEE6),
              overlayColor: Colors.black,
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
                  onTap: () async {
                    if (viewModel.origin != null && viewModel.destination == null) {
                      final directions = await DirectionRepo().getDirection(viewModel.origin!.position, evacPosition);
                      setState(() {
                        viewModel.direct = directions;
                      });
                    }
                    else {
                      setState(() {
                        viewModel.destination = null;
                      });
                      final directions = await DirectionRepo().getDirection(viewModel.origin!.position, evacPosition);
                      setState(() {
                        viewModel.direct = directions;
                      });
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
            CameraUpdate.newCameraPosition(_initialCameraPosition) //move to initial position,
          ),
          child: Icon(Icons.center_focus_strong),
        ),
      ),

    );
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
          infoWindow: InfoWindow(title: 'Your origin ${pos.toString()}'), //display text over the marker
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
          infoWindow: InfoWindow(title: 'Your destination ${pos.toString()}'), //display text over the marker
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
          "Maps",
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