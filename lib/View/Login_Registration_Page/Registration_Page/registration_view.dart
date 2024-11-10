import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/ViewModel/Registration_View_Models/register_firebase_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/Registration_View_Models/registration_view_model.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

List<String> options =["Male", "Female"]; //for radio list

class _RegistrationViewState extends State<RegistrationView> {

  //DefaultBox height
  double _whiteContainerHeight = 750.r + 40.r;

  //password values
  bool _isObscure1 =  true;
  bool _isObscure2  = true;

  //form global key
  final _formKey = GlobalKey<FormState>();

  //gender current value
  String currentOption = options[0];

  //register view model instance
  RegisterFirebaseViewModel firebaseViewModel = RegisterFirebaseViewModel();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 500.r,
          height: 1110.r,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/Register.jpg'),
              fit: BoxFit.cover
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 25, 8, 5).r,
            child: Column(
              children: [
                //Logo and Title
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 240.r,
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
                                style: TextStyle(
                                  color: Color(0xFF3D424A),
                                ),
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
                                controller: viewModel.bdayController,
                                readOnly: true,
                                cursorColor: const Color(0xFF3D424A),
                                style: TextStyle(
                                  color: Color(0xFF3D424A),
                                ),
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
                              Wrap(
                                spacing: 12.r,
                                runSpacing: 4.r,
                                crossAxisAlignment: WrapCrossAlignment.start,
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
                                                    color: Color(0xFF3D424A),
                                                    fontSize: 14.r
                                                    )
                                                  )
                                                ),
                                              );
                                            }
                                          }
                                
                                          return DropdownButton(
                                            hint: const Text(
                                              "Your Municipality",
                                              style: TextStyle(
                                                color: Color(0xFF3D424A),
                                              ),
                                            ),
                                            value: viewModel.municipalId,
                                            items: municipalities,
                                            style: TextStyle(
                                              color: Color(0xFF3D424A),
                                            ),
                                            iconSize: 28.r,
                                            iconEnabledColor: Color(0xFF3D424A),
                                            dropdownColor: Color(0xFFEDEDED),
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
                              
                              
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('municipalities').doc(viewModel.municipalId).collection('Barangays').snapshots(),
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
                                                    color: Color(0xFF3D424A),
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
                                            iconEnabledColor: Color(0xFF3D424A),
                                            dropdownColor: Color(0xFFEDEDED),
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
                                    fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                    if (states.contains(WidgetState.disabled)) {
                                      return const Color(0xFF854F6C);
                                    }
                                    return const Color(0xFF854F6C);
                                  }),
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
                                    fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                    if (states.contains(WidgetState.disabled)) {
                                      return const Color(0xFF854F6C);
                                    }
                                    return const Color(0xFF854F6C);
                                  }),
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
                                style: const TextStyle(
                                  color: Color(0xFF3D424A),
                                ),
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
                                style: const TextStyle(
                                  color: Color(0xFF3D424A),
                                ),
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
                                obscureText: _isObscure1,
                                cursorColor: const Color(0xFF3D424A),
                                style: const TextStyle(
                                  color: Color(0xFF3D424A),
                                ),
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
                                  ),
                                  suffixIcon: IconButton(
                                    color: const Color(0xFF3D424A),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure1 = ! _isObscure1;
                                      });
                                    },
                                    icon: _isObscure1 ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off) ,
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

                              //confirm password
                              TextFormField(
                                controller: viewModel.confirmPasswordController,
                                obscureText: _isObscure2,
                                cursorColor: const Color(0xFF3D424A),
                                style: const TextStyle(
                                  color: Color(0xFF3D424A),
                                ),
                                decoration: InputDecoration(
                                  hintText: "Comfirm Password",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF3D424A)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 2.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.5.r, color: const Color(0xFF3D424A))
                                  ),
                                  suffixIcon: IconButton(
                                    color: const Color(0xFF3D424A),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure2 = ! _isObscure2;
                                      });
                                    },
                                    icon: _isObscure2 ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off) ,
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
                                      if (_formKey.currentState!.validate() && viewModel.barangayValue != null){
                                        //validated the text field and adds to the firebase, pass to register view model
                                        _formKey.currentState!.save();
                                        setState(() {
                                          _whiteContainerHeight = 750.r + 60.r;
                                        });
                                        firebaseViewModel.addUser(
                                          context, 
                                          viewModel.nameController.text, 
                                          viewModel.bdayController.text, 
                                          currentOption, 
                                          viewModel.barangayValue!, 
                                          viewModel.municipalityValue!, 
                                          viewModel.emailController.text, 
                                          viewModel.contactController.text, 
                                          viewModel.passwordController.text, 
                                          viewModel.confirmPasswordController.text,
                                          "user",
                                          []
                                        );
                                        
                                        Navigator.pop(context);
                                      }
                                      else if (viewModel.barangayValue == null || viewModel.municipalityValue ==  null) {
                                        //edit the design
                                        showDialog(
                                          context: context, 
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: const Color(0xE6FCFCFC),
                                              title: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.error_outline,
                                                    color: Color(0xFF3D424A),
                                                  ),

                                                  SizedBox(width: 8,),

                                                  Text(
                                                    "Notice",
                                                    style: TextStyle(
                                                      color: Color(0xFF3D424A)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              titleTextStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),

                                              contentPadding: const EdgeInsets.only(left: 2),
                                              content: Container(
                                                padding: const EdgeInsets.only(left: 15, top: 25, right: 15),
                                                height: 95,
                                                child: const Text(
                                                  "Some input fields are still missing",
                                                  style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF3D424A)
                                                ),
                                              ),
                                              ),
                                            );
                                          },
                                        );

                                        setState(() {
                                          _whiteContainerHeight = 750.r + 60.r;
                                        });
                                      }
                              
                                      else {
                                        setState(() {
                                          _whiteContainerHeight = 830.r;
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
                                      Navigator.pop(context);
                                    }, 
                                    child: Text(
                                      "Login Page",
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