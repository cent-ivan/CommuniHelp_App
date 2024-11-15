import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShareAppView extends StatelessWidget {
  const ShareAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
        title: Text(
          "About App",
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
            Navigator.pop(context);
          },
        ),
        
      ),
      body: Center(
        child: 
        Container(),
      ),
    );
  }
}