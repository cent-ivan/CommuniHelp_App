import 'package:communihelp_app/View/Utility_Pages/Evacuation_Finder/Evacuation_Widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvacautionFinderView extends StatefulWidget {
  const EvacautionFinderView({super.key});

  @override
  State<EvacautionFinderView> createState() => _EvacautionFinderViewState();
}

class _EvacautionFinderViewState extends State<EvacautionFinderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MapAppBar(),

      body: const MapWidget(),
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
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),
          
        child: const Text(
          "Report To Authorities",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
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