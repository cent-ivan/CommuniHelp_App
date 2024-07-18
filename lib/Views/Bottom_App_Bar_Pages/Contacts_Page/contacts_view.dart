import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}


//to make the text color of the page adapt to dark mode enter this `Theme.of(context).colorScheme.outline`
//for the contact tiles here is the color: `Theme.of(context).colorScheme.primary`
//if you find the code to be difficult jsut search in youtube `contacts app in flutter`
//when putting sizes in double data type add `.r` at the end Ex: 13.r/ EdgeInsets.all(13).r for paddings
class _ContactsViewState extends State<ContactsView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(13).r,
          child: Container(
            child: const Text("Enter your code here:"), //remove the text widget
            
          ),
        ),
      
      
      ),
    );
  }
}