import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManMadeDisasterView extends StatelessWidget {
  const ManMadeDisasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: ManMadeAppBar(),
    );
  }
}



//APP BAR---------------------------------------------------------------------------------------------
class ManMadeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ManMadeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1.r,
      title: Text(
        "Kalamidad na ubra it tawo",
        style: TextStyle(
          color: Theme.of(context).colorScheme.outline,
          fontSize: 20.r,
          fontWeight: FontWeight.bold
        ),
      ),
    
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20.r,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
        },
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);

}