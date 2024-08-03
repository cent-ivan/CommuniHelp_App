import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

List<String> options =["Male", "Female"]; //for radio list

class _RegistrationViewState extends State<RegistrationView> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  //text field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _municipalityValue = "Nabas";
  final String _barangayValue = "Unidos";
  String currentOption = options[0];
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 500.r,
          height: 920.r,
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
                  height: 625.r,
                  width: 320.r,
                  decoration: BoxDecoration(
                    color: const Color(0x99FCFCFC),
                    borderRadius: BorderRadius.circular(20.r)
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
                                  fontSize: 20.r,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2
                                ),
                              ),


                            ],
                          ),
                        ),
                    
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [

                              //name
                              TextFormField(
                                controller: _nameController,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Name",
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

                              //Birthdate
                              TextFormField(
                                controller: _ageController,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Birthdate",
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
                                    return "Please enter birthdate";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),

                              SizedBox(height: 10.r,),

                              //Dropdown address
                              Row(
                                children: [
                                  DropdownButton(
                                    hint: const Text("Municipality"),
                                    value: _municipalityValue,
                                    underline: Container(
                                      height: 2,
                                      color: const Color(0xFF3D424A),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Nabas",
                                        child: Text(
                                          "Nabas",
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "Malay",
                                        child: Text(
                                          "Malay",
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        ),
                                      ),
                                    ], 
                                    onChanged: (newValue) {
                                      setState(() {
                                        _municipalityValue = newValue!;
                                      });
                                    }                    
                                  ),

                                  SizedBox(width: 50.r,),

                                  DropdownButton(
                                    hint: const Text("Barangay"),
                                    value: _barangayValue,
                                    underline: Container(
                                      height: 2,
                                      color: const Color(0xFF3D424A),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Unidos",
                                        child: Text(
                                          "Unidos",
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "Caticlan",
                                        child: Text(
                                          "Malay",
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        ),
                                      ),
                                    ], 
                                    onChanged: (newValue) {
                                      setState(() {
                                        _municipalityValue = newValue!;
                                      });
                                    }
                                  ),
                                ],
                              ),

                              SizedBox(height: 10.r,),

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


                              //contact number
                              TextFormField(
                                controller: _contactController,
                                cursorColor: const Color(0xFF3D424A),
                                maxLength: 11,
                                keyboardType: TextInputType.number, //accepts only intgers
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  hintText: "Contact Number",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
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
                                controller: _emailController,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
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

                              //password
                              TextFormField(
                                controller: _passwordController,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                                  )
                                ),

                                validator: (value) {
                                  if (value!.isEmpty){
                                    return "Please enter password";
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