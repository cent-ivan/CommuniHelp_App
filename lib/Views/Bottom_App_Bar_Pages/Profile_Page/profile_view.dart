import 'package:communihelp_app/ViewModels/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  double spaceBetweenDetails = 20.r;
  double spaceBetweenLabel = 2.5.r;
  AssetImage profileImage = const AssetImage('assets/images/rescuer.png');


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Container(
            height: 785,
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 5).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 24.r,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                SizedBox(height: 18.r,),

                //Profile Picture
                Center(
                  child: CircleAvatar(
                    backgroundImage: profileImage,
                    radius: 40.r,
                  ),
                ),

                Divider(
                  color: Theme.of(context).colorScheme.surface,
                  height: 45.r,
                ),

                //Personal Details
                Consumer<ProfileViewModel>(builder: (context, viewModel, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Details",
                        style: TextStyle(
                          color: const Color(0xFFFEAE49),
                          fontSize: 20.r,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(height: 10.r,),

                      //Details---
                      //FullName
                      Text(
                        "Full Name",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 14.r,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                      SizedBox(height: spaceBetweenLabel,),

                      Text(
                        viewModel.profile.name!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 18.r,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                        ),
                      ),
                    

                      SizedBox(height: spaceBetweenDetails,),

                      //Birthdate
                      Text(
                        "Birthdate",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 14.r,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5
                        ),
                      ),

                      SizedBox(height: spaceBetweenLabel,),

                      Text(
                        viewModel.profile.birthdate!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 18.r,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),


                      SizedBox(height: spaceBetweenDetails,),

                      //Gender
                      Text(
                        "Gender",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 14.r,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5
                        ),
                      ),

                      SizedBox(height: spaceBetweenLabel,),

                      Text(
                        viewModel.profile.gender!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 18.r,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),


                      SizedBox(height: spaceBetweenDetails,),

                      //Barangay and Municipality
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Barangay",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 14.r,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5
                                ),
                              ),

                              SizedBox(height: 3.r,),

                              Text(
                                viewModel.profile.barangay!,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 18.r,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              Text(
                                "Municipality",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 14.r,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5
                                ),
                              ),

                              SizedBox(height: 3.r,),

                              Text(
                                viewModel.profile.municipality!,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 18.r,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 10.r,)
                        ],
                      ),

                      SizedBox(height: 25.r,),

                      //Contact Number
                      Text(
                        "Contact Number",
                        style: TextStyle(
                          color: const Color(0xFFFEAE49),
                          fontSize: 20.r,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(height: 10.r,),

                      Text(
                        "Mobile number",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 14.r,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                      SizedBox(height: spaceBetweenLabel,),

                      Text(
                        viewModel.profile.mobileNumber!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 18.r,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                        ),
                      ),

                      SizedBox(height: 35.r,),

                      MaterialButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/editprofile');
                        },
                        height: 50.r,
                        minWidth: 340.r,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.r))
                        ),
                        color: const Color(0xFF57BEE6),
                        child: Center(
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 14.r,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}