import 'package:communihelp_app/ViewModels/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

List<String> options =["Male", "Female"]; //for radio list

class _EditProfileViewState extends State<EditProfileView> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  //text field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final String _municipalityValue = "Nabas";
  String _barangayValue = "Unidos";
  String currentOption = options[0];
  final TextEditingController _contactController = TextEditingController();

  double spaceBetweenDetails = 20.r;
  double spaceBetweenLabel = 2.5.r;
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Edit Profile"
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Container(
            height: 785,
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 5).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(height: 24.r,),

                //Profile Picture
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage('assets/images/rescuer.png'),
                        radius: 40.r,
                      ),
                  
                      //Edit Profile Button
                      Positioned(
                        right: 0.r,
                        bottom: 0.r,
                        child: Container(
                          width: 25.r,
                          height: 25.r,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(50.r),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline
                            )
                          ),
                        ),
                      ),
                  
                      Positioned(
                        right: -10.r,
                        bottom: -10.r,
                        child: IconButton(
                          color: Theme.of(context).colorScheme.outline,
                          //change profile
                          onPressed: (){
                  
                          }, 
                          icon: const Icon(Icons.camera_alt),
                          iconSize: 15.r,
                        ),
                      )
                    ],
                  ),
                ),

                Divider(
                  color: Theme.of(context).colorScheme.surface,
                  height: 45.r,
                ),

                //Personal Details
                Form(
                  key: _formKey,
                  child: Consumer<ProfileViewModel>(builder: (context, viewModel, child) => Column(
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
                          controller: _nameController,
                          cursorColor: const Color(0xFF3D424A),
                          style: TextStyle(
                            fontSize: 18.r
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
                          controller: _birthdateController,
                          cursorColor: const Color(0xFF3D424A),
                          style: TextStyle(
                            fontSize: 18.r
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

                              }, 
                              icon: const Icon(Icons.date_range_outlined),
                              color: const Color(0xCC3D424A),
                              splashColor: const Color(0xFF3D424A),
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
                  
                        //Gender edit
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
                  
                        Row(
                          children: [
                            Radio<String>(
                              activeColor: const Color(0xFF854F6C),
                              value: options[0],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),

                            Text(options[0]),

                            SizedBox(width: 60.r,),

                            Radio(
                              activeColor: const Color(0xFF854F6C),
                              value: options[1],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),

                            Text(options[1]),
                          ],
                        ),
                  
                  
                        SizedBox(height: spaceBetweenDetails,),
                  
                        //Barangay and Municipality
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                  
                                DropdownButton(
                                  hint: const Text("Barangay"),
                                  value: _barangayValue ,
                                  underline: Container(
                                    height: 2,
                                    color: const Color(0xFF3D424A),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: "Unidos",
                                      child: Text(
                                        "Unidos",
                                        style: TextStyle(
                                           fontSize: 14.r
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "Libertad",
                                      child: Text(
                                        "Libertad",
                                        style: TextStyle(
                                           fontSize: 14.r
                                        ),
                                      ),
                                    ),
                                  ], 
                                  onChanged: (newValue) {
                                    setState(() {
                                      _barangayValue = newValue!;
                                    });
                                  }                    
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
                  
                                DropdownButton(
                                  hint: const Text("Municipality"),
                                  value: _municipalityValue,
                                  underline: Container(
                                    height: 2,
                                    color: const Color(0xFF3D424A),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: "Nabas",
                                      child: Text(
                                        "Nabas",
                                        style: TextStyle(
                                           fontSize: 14.r
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "Malay",
                                      child: Text(
                                        "Malay",
                                        style: TextStyle(
                                           fontSize: 14.r
                                        ),
                                      ),
                                    ),
                                  ], 
                                  onChanged: (newValue) {
                                    setState(() {
                                      _barangayValue = newValue!;
                                    });
                                  }                    
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
                  
                        TextFormField(
                          controller: _contactController,
                          cursorColor: const Color(0xFF3D424A),
                          style: TextStyle(
                            fontSize: 18.r
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
                  
                        SizedBox(height: 35.r,),
                  
                        MaterialButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, '/profile');
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
    );
  }
}