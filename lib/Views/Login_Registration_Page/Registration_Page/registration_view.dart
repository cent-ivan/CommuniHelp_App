import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../ViewModels/Login_Registration_View_Models/registration_view_model.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

List<String> options =["Male", "Female"]; //for radio list

class _RegistrationViewState extends State<RegistrationView> {

  //DefaultBox height
  double _whiteContainerHeight = 675.r;

  //form global key
  final _formKey = GlobalKey<FormState>();

  String currentOption = options[0];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 500.r,
          height: 980.r,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/Register.jpg'),
              fit: BoxFit.cover
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 25, 8, 8).r,
            child: Column(
              children: [
                //Logo and Title
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 280.r,
                      child: const Image(
                        image: AssetImage('assets/images/logo/communiHelpLogo.png')
                      ),
                    ),

                    //Logo and title
                    Positioned(
                      top: 120.r,
                      child: Text(
                        "Registration",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.r,
                          letterSpacing: 2.r,
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              offset: const Offset(0, 0),
                              blurRadius: 20.r
                            )
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 15,),

                //registration form container
                Container(
                  height: _whiteContainerHeight,
                  width: 328.r,
                  decoration: BoxDecoration(
                    color: const Color(0xB3FCFCFC),
                    borderRadius: BorderRadius.circular(12.r)
                  ),
        
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18, left: 16, right: 16).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5.r),
                          child: Row(
                            children: [
                              Text(
                                "Personal Information",
                                style: TextStyle(
                                  color: const Color(0xFF3D424A),
                                  fontSize: 20.r,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5
                                ),
                              ),


                            ],
                          ),
                        ),
                    
                        Consumer<RegistrationViewModel>(builder: (context, viewModel, child) => Form(
                          key: _formKey,
                          child: Column(
                            children: [

                              //name
                              TextFormField(
                                controller: viewModel.nameController,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF3D424A)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 2.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.5.r, color: const Color(0xFF3D424A))
                                  ),
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

                              SizedBox(height: 13.r,),

                              //Birthdate
                              TextFormField(
                                controller: viewModel.ageController,
                                readOnly: true,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Birthdate (mm/dd/yyyy)",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF3D424A)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 2.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.5.r, color: const Color(0xFF3D424A))
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
                                    return "Please enter birthdate";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),

                              SizedBox(height: 13.r,),

                              //Dropdown address
                              Row(
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('municipalities').snapshots(), 
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Center(child: Text("some error occured ${snapshot.error}"),);
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
                                                    fontSize: 14.r
                                                    )
                                                  )
                                                ),
                                              );
                                            }
                                          }
                                
                                          return DropdownButton(
                                            hint: const Text("Your Municipality"),
                                            value: viewModel.municipalId,
                                            items: municipalities, 
                                            iconSize: 28.r,
                                            underline: Container(
                                              height: 2.3,
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

                                    SizedBox(width: 20.r,),

                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('municipalities').doc(viewModel.municipalId).collection('Cities').snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Center(child: Text("some error occured ${snapshot.error}"),);
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
                                                    fontSize: 14.r
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
                                                color: viewModel.isActive ? const Color(0xFF3D424A) : const Color(0xFF808080)
                                              )
                                            ),
                                            value: viewModel.barangayId,
                                            items: viewModel.isActive ? barangays : null, 
                                            iconSize: 28.r,
                                            underline: Container(
                                              height: 2.3,
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
                          

                              SizedBox(height: 19.r,),


                              //Gender Title
                              Row(
                                children: [
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                      color: const Color(0xFF3D424A),
                                      fontSize: 20.r,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5.r
                                    ),
                                  ),
                                ],
                              ),

                              //Gender radio bottons
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

                                  Text(
                                    options[0],
                                    style: const TextStyle(
                                      color: Color(0xFF3D424A),
                                    ),
                                  ),

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

                                  Text(
                                    options[1],
                                    style: const TextStyle(
                                      color: Color(0xFF3D424A),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: 13.r,),

                              const Divider(color: Color(0xE63D424A),),

                
                              //Contact Title
                              Row(
                                children: [
                                  Text(
                                    "Contact Details",
                                    style: TextStyle(
                                      color: const Color(0xFF3D424A),
                                      fontSize: 20.r,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5.r
                                    ),
                                  ),
                                ],
                              ),

                              //contact number
                              TextFormField(
                                controller: viewModel.contactController,
                                cursorColor: const Color(0xFF3D424A),
                                maxLength: 11,
                                keyboardType: TextInputType.number, //accepts only intgers
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  hintText: "Contact Number",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF3D424A)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 2.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.5.r, color: const Color(0xFF3D424A))
                                  )
                                ),

                                validator: (value) {
                                  if (value!.isEmpty){
                                    return "Please enter contact";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),

                              //email
                              TextFormField(
                                controller: viewModel.emailController,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF3D424A)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 2.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.5.r, color: const Color(0xFF3D424A))
                                  )
                                ),

                                validator: (value) {
                                  if (value!.isEmpty){
                                    return "Please enter an email";
                                  }
                                  else if (!value.contains('@')){
                                    return "Enter a valid email";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),

                              SizedBox(height: 13.r,),

                              //password
                              TextFormField(
                                controller: viewModel.passwordController,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF3D424A)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 2.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.5.r, color: const Color(0xFF3D424A))
                                  )
                                ),

                                validator: (value) {
                                  if (value!.isEmpty){
                                    return "Please enter a password";
                                  }
                                  else if (value.length < 4) {
                                    return "Password must be 6 characters or longer";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),

                              SizedBox(height: 35.r,),

                              //register button
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    height: 50.r,
                                    minWidth: 100.r,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()){
                                        //validated the text field and adds to the firebase, pass to register view model
                                        _formKey.currentState!.save();
                                        setState(() {
                                          _whiteContainerHeight = 675.r;
                                        });
                                      }
                                      else {
                                        setState(() {
                                          _whiteContainerHeight = 710.r;
                                        });
                                      }
                                    },
                                    color: const Color(0xFF3D424A),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 14.r,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.r,
                                        decoration: TextDecoration.underline
                                      ),
                                    ),
                                  ),

                                  //Back to login link
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context, '/login');
                                    }, 
                                    child: Text(
                                      "Member na ako",
                                      style: TextStyle(
                                        fontSize: 12.r,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF3D424A)
                                      ),
                                    )
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        )
                      ],
                    ),
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