import 'package:flutter/material.dart';

class ManMadeDisasterView extends StatelessWidget {
  const ManMadeDisasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
        title: Text(
          "Kalamidad na ubra it tawo",
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20,
          onPressed: () {
            Navigator.popAndPushNamed(context, '/home');
          },
        ),
      ),
    );
  }
}