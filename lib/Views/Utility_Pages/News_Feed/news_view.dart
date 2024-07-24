import 'package:flutter/material.dart';


class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
      
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 1,
          title: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
            ).createShader(bounds),
      
            child: const Text(
              "News Feed",
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
              Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
            },
          ),
        ),
      
        //Tab contents, entre code here
        body: Container()
      ),
    );
  }
}