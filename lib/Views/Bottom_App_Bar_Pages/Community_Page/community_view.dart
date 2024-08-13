import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: const PageStorageKey<String>('CommunityView'),

        backgroundColor: Theme.of(context).colorScheme.surface,

        body: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              GestureDetector(
                //add post add post dialog
                onTap: () {

                },
                child: Container(
                  height: 50.r,
                  padding: EdgeInsets.only(left: 25.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                
                        },
                        icon: const Icon(Icons.post_add_rounded),
                        iconSize: 30.r,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                
                      TextButton(
                        onPressed: () {
                
                        }, 
                        child: Text(
                          "Share a thought",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 16.r,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}