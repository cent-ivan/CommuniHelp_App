import 'package:flutter/material.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        key: PageStorageKey<String>('CommunityView'),
        body: Center(
          child: Text("Community"),
        ),
      ),
    );
  }
}