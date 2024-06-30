import 'package:flutter/material.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Magtawag it emergency",
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),

        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
        
      ),
    );
  }
}