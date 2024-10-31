import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_announcement.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/user_registration.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Profile_Page/pick_profile_dialog.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/emergency_view_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}



class _EditProfileViewState extends State<EditProfileView> {
  Logger logger = Logger(); //for debug message
  
  //form global key
  final _formKey = GlobalKey<FormState>();

  
  double _screenSize = 895.r + 100.r;
  double spaceBetweenDetails = 20.r;
  double spaceBetweenLabel = 2.5.r;

  //Firestore instance for update
  final firestoreService = FireStoreAddService();

  GetUserData userData = GetUserData();
  GetAnnouncement getAnnouncement = GetAnnouncement();

  //show dialog pick image
  final pickDialog = PickProfileDialog();

  @override
  Widget build(BuildContext context) {
    final emergencyViewModel = Provider.of<EmergencyViewModel>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Consumer<ProfileViewModel>(builder: (context, viewModel, child) => Container(
              decoration: BoxDecoration(
                image:  DecorationImage(image: Theme.of(context).colorScheme.primary == const Color(0xFFF2F2F2) ? 
                  const AssetImage('assets/images/background/ProfileBackground.png') : const AssetImage('assets/images/background/ProfileDarkBackground.png'), 
                fit: BoxFit.cover),
              
              ),
              height: _screenSize,
              padding: const EdgeInsets.fromLTRB(12, 25, 12, 5).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(height: 24.r,),
            
                  //Profile Picture
                  Center(
                    child: Stack(
                      children: [
                        //------Edit profile---------------------------------------------------------
                        viewModel.profileImage != null ?
                        CircleAvatar(
                          backgroundImage: FileImage(viewModel.profileImage!),
                          radius: 65.r,
                        )
                        : Center(
                            child: userData.userProfURL.isNotEmpty ? CachedNetworkImage(
                              imageUrl: userData.userProfURL,
                              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                backgroundImage: imageProvider,
                                radius: 65.r,
                              )
                            ) 
                            :
                            CircleAvatar(
                              backgroundImage: const AssetImage('assets/images/rescuer.png'),
                              radius: 60.r,
                            ),
                          ),
                    
                        //Edit Profile Button
                        Positioned(
                          right: -10.r,
                          bottom: 0.r,
                          child: MaterialButton(
                            minWidth: 40.r,
                            onPressed: () {
                              pickDialog.showPickScreen(context);
                            },
                            child: Image(
                              width: 30.r,
                              height: 30.r,
                              image: AssetImage('assets/images/dashboard/uploadphoto.png'),
                            ),
                          )
                        )
                      ],
                    ),
                  ),
            
                  SizedBox(height: 45.r,),
            
                  //Personal Details
                  Container(
                    padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                      color:  const Color(0xF2F5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(10.r))
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
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
                            //FullName Edit
                            TextFormField(
                              controller: viewModel.nameController,
                              cursorColor: const Color(0xFF3D424A),
                              textCapitalization: TextCapitalization.sentences,
                              style: TextStyle(
                                fontSize: 14.r,
                                color: const Color(0xFF3D424A)
                              ),
                              decoration: InputDecoration(
                              hintText: "Edit Name",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                                ),
                                focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                                )
                              ),
                    
                              validator: (value) {
                                if (value!.isEmpty){
                                  return "Please enter name";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          
                      
                            SizedBox(height: spaceBetweenDetails,),
                      
                            //Birthday Edit
                            TextFormField(
                              controller: viewModel.birthdateController,
                              cursorColor: const Color(0xFF3D424A),
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 14.r,
                                color: const Color(0xFF3D424A)
                              ),
                              decoration: InputDecoration(
                                hintText: "Edit Birthday",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                                ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                                ),
                    
                                //Date picker
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    viewModel.pickDate(context);
                                  }, 
                                  icon: const Icon(Icons.date_range_outlined),
                                  color: const Color(0xCC3D424A),
                                  splashColor: const Color(0xFF3D424A),
                                )
                    
                              ),
                    
                              validator: (value) {
                                if (value!.isEmpty){
                                  return "Please enter birth date";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                      
                      
                            SizedBox(height: spaceBetweenDetails,),
                      
                            //Gender edit
                            Text(
                              "Gender",
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 14.r,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5
                              ),
                            ),
                      
                            SizedBox(height: spaceBetweenLabel,),
            
                            //gender
                            Row(
                              children: [
                                Radio<String>(
                                  fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                      if (states.contains(WidgetState.disabled)) {
                                        return const Color(0xFF854F6C);
                                      }
                                      return const Color(0xFF854F6C);
                                    }),
                                  value: options[0],
                                  groupValue: viewModel.currentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      viewModel.currentOption = value.toString();
                                    });
                                  },
                                ),
                                                  
                                Text(options[0], style: TextStyle(color: const Color(0xFF3D424A)),),
                    
                                SizedBox(width: 60.r,),
                    
                                Radio(
                                  fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                      if (states.contains(WidgetState.disabled)) {
                                        return const Color(0xFF854F6C);
                                      }
                                      return const Color(0xFF854F6C);
                                    }),
                                  value: options[1],
                                  groupValue: viewModel.currentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      viewModel.currentOption = value.toString();
                                    });
                                  },
                                ),
                    
                                Text(options[1], style: TextStyle(color: const Color(0xFF3D424A)),),
                              ],
                            ),
                      
                      
                            SizedBox(height: spaceBetweenDetails,),
                      
                            //Barangay and Municipality
                            Wrap(
                              spacing: 4.r,
                              runSpacing: 4.r,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Municipality",
                                      style: TextStyle(
                                        color: const Color(0xFF3D424A),
                                        fontSize: 14.r,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5
                                      ),
                                    ),
                      
                                    SizedBox(height: 3.r,),
                      
                                    StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance.collection('municipalities').snapshots(), 
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return Center(child: Text("Error occured: ${snapshot.error}"),);
                                            }
                                            List<DropdownMenuItem> municipalities = [];
                                            if (!snapshot.hasData) {
                                              return const CircularProgressIndicator.adaptive();
                                            }
                                            else {
                                              final selectMunicipal = snapshot.data?.docs.toList();
                                              if (selectMunicipal != null) {
                                                for (var municipal in selectMunicipal) {
                                                  municipalities.add(DropdownMenuItem(
                                                      value: municipal.id,
                                                      child: Text(
                                                        municipal["name"],
                                                        style: TextStyle(
                                                        color: const Color(0xFF3D424A),
                                                        fontSize: 12.r
                                                        )
                                                      )
                                                    ),
                                                  );
                                                }
                                              }
                                              return DropdownButton(
                                                hint: const Text("Your Municipality", style: TextStyle(color: Color(0xFF3D424A)),),
                                                value: viewModel.municipalId,
                                                items: municipalities, 
                                                iconSize: 28.r,
                                                iconEnabledColor: const Color(0xFF3D424A),
                                                dropdownColor: Color(0xFFEDEDED),
                                                underline: Container(
                                                  height: 2,
                                                  color: const Color(0xFF3D424A),
                                                ),
                                                onChanged: (value) {
                                                  viewModel.updateMunicipal(value);
                                                  if (value != null) {
                                                    viewModel.barangayId = null;
                                                  }
                                                  else {
                                                    viewModel.updateMunicipal(value);
                                                  }
                                                }
                                              );
                                            }
                                          }
                                      ),
                    
                                  ],
                                ),
            
                                SizedBox(height: 3.r,),
                      
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Barangay",
                                      style: TextStyle(
                                        color: const Color(0xFF3D424A),
                                        fontSize: 14.r,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5
                                      ),
                                    ),
                      
                                    SizedBox(height: 3.r,),
                      
                                    StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance.collection('municipalities').doc(viewModel.municipalId).collection('Barangays').snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return Center(child: Text("Error occured: ${snapshot.error}"),);
                                            }
                                            List<DropdownMenuItem> barangays = [];
                                            if (!snapshot.hasData) {
                                              return const CircularProgressIndicator.adaptive();
                                            }
                                            else {
                                              final selectBarangay = snapshot.data?.docs.toList();
                                              if (selectBarangay  != null) {
                                                for (var barangay in selectBarangay ) {
                                                  barangays.add(DropdownMenuItem(
                                                      value: barangay.id,
                                                      child: Text(
                                                        barangay["name"],
                                                        style: TextStyle(
                                                        color: const Color(0xFF3D424A),
                                                        fontSize: 12.r
                                                        )
                                                      )
                                                    ),
                                                  );
                                                }
                                              }
                                              return DropdownButton(
                                                hint: Text(
                                                  "Your Barangay",
                                                  style: TextStyle(
                                                    color: viewModel.isActive? const Color(0xFF3D424A) : const Color(0xFF808080)
                                                  )
                                                ),
                                                value: viewModel.barangayId,
                                                items: viewModel.isActive? barangays : null, 
                                                iconSize: 28.r,
                                                iconEnabledColor: const Color(0xFF3D424A),
                                                dropdownColor: Color(0xFFEDEDED),
                                                underline: Container(
                                                  height: 2,
                                                  color: const Color(0xFF3D424A),
                                                ),
                                                onChanged: (value) {
                                                  viewModel.updateBarangay(value);
                                                }
                                              );
                                            }
                                          }
                                      ),
                                  ],
                                ),
                      
                                SizedBox(width: 10.r,)
                              ],
                            ),
                      
                            SizedBox(height: 40.r,),
                      
                            //Contact Number
                            Text(
                              "Contact Details",
                              style: TextStyle(
                                color: const Color(0xFFFEAE49),
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold
                              ),
                            ),
            
                    
                            // Text(
                            //   "Email",
                            //   style: TextStyle(
                            //     color: Theme.of(context).colorScheme.outline,
                            //     fontSize: 14.r,
                            //     fontWeight: FontWeight.w500
                            //   ),
                            // ),
                    
                            // SizedBox(height: spaceBetweenLabel,),
                    
                            //edit email
                            // TextFormField(
                            //   controller: viewModel.emailController,
                            //   cursorColor: const Color(0xFF3D424A),
                            //   style: TextStyle(
                            //     fontSize: 18.r
                            //   ),
                            //   decoration: InputDecoration(
                            //     hintText: "Edit Email",
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                            //     ),
                            //     focusedBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                            //     )
                            //   ),
                    
                            //   validator: (value) {
                            //     if (value!.isEmpty){
                            //       return "Please enter an email";
                            //     }
                            //     else if (!value.contains('@')){
                            //       return "Enter a valid email";
                            //     }
                            //     else{
                            //       return null;
                            //     }
                            //   },
                            // ),
                    
                    
                            SizedBox(height: spaceBetweenDetails,),
                    
                            Text(
                              "Mobile number",
                              style: TextStyle(
                                color: const Color(0xFF3D424A),
                                fontSize: 14.r,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                      
                            SizedBox(height: spaceBetweenLabel,),
                    
                            //edit contacts
                            TextFormField(
                              controller:  viewModel.contactController,
                              cursorColor: const Color(0xFF3D424A),
                              maxLength: 11,
                              keyboardType: TextInputType.number, //accepts only intgers
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontSize: 18.r,
                                color: const Color(0xFF3D424A)
                              ),
                              decoration: InputDecoration(
                              hintText: "Edit Contact Number",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                                ),
                                focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                                )
                              ),
                    
                              validator: (value) {
                                if (value!.isEmpty){
                                  return "Please enter name";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                      
                            SizedBox(height: 25.r,),
            
                            //Save Button
                            MaterialButton( 
                              onPressed: (){
                                if (_formKey.currentState!.validate() && viewModel.barangayValue != null){
                                    //validated the text field and adds to the firebase, pass to register view model
                                    _formKey.currentState!.save();
    
                                    setState(() {
                                      _screenSize = 895.r + 100.r;
                             
                                      userData.reloadData();
                                      emergencyViewModel.reloadLists();

                                      viewModel.updateUserData();
                                    });

                                    Navigator.pop(context);
                                    
                                }
                                else if (viewModel.barangayValue == null || viewModel.municipalityValue ==  null) {
                                  //edit the design
                                  showDialog(
                                    context: context, 
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: const Color(0xFFDFB6B2),
                                        title: const Row(
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.white,
                                            ),
            
                                            SizedBox(width: 8,),
            
                                            Text("No address selected"),
                                          ],
                                        ),
                                        titleTextStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                        ),
            
                                        contentPadding: const EdgeInsets.only(left: 2),
                                        content: Container(
                                          padding: const EdgeInsets.only(left: 15, top: 20, right: 20),
                                          height: 95,
                                          child: const Text(
                                            "Make sure you select an address ",
                                            style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                else {
                                  setState(() {
                                    _screenSize = _screenSize + 70.r;
                                  });
                                }
                                
                              },
                              height: 50.r,
                              minWidth: 340.r,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.r))
                              ),
                              color: const Color(0xFF57BEE6),
                              child: Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.outline,
                                    fontSize: 18.r,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            
                            SizedBox(height: 15.r,),
            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //change email
                                TextButton(
                                  onPressed: () {
                                    
                                  }, 
                                  child: Text(
                                    "Change email here",
                                    style: TextStyle(
                                      color: const Color(0xFF3D424A),
                                      fontSize: 14.r,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline
                                    ),
                                  )
                                ),
            
                                //change password
                                TextButton(
                                  onPressed: () {
                                    
                                  }, 
                                  child: Text(
                                    "Change password here",
                                    style: TextStyle(
                                      color: const Color(0xFF3D424A),
                                      fontSize: 14.r,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline
                                    ),
                                  )
                                ),
                              ],
                            )
                          ],
                        )
                      
                    ),
                  ),
            
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }

  
}