import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  bool _isObscure =  true;

  //controllers
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: 500.r,
          height: 755.r,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/Login.jpg'),
              fit: BoxFit.cover
            ),
          ),
        
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 8).r,
            child: Column(
              children: [
                //Logo and title 
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 300.r,
                      child: const Image(
                        image: AssetImage('assets/images/logo/communiHelpLogo.png')
                      ),
                    ),

                    //Logo and title
                    Positioned(
                      top: 120.r,
                      child: Text(
                        "CommuniHelp",
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
        
                    Positioned(
                      top: 160.r,
                      child: Text(
                        "Disaster Preparedness Asssistance and Utility App",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.r,
                          shadows: [
                            Shadow(
                              color: Colors.white,
                              offset: const Offset(0, 0),
                              blurRadius: 50.r
                            )
                          ]
                        ),
                      ),
                    )
                  ],
                ),
                
                const SizedBox(height: 20,),
        
                //Login box
                Container(
                  height: 310.r,
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
                                "Login",
                                style: TextStyle(
                                  color: const Color(0xFF3D424A),
                                  fontSize: 32.r,
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

                              //mobile number
                              TextFormField(
                                controller: _numberController,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF3D424A)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                                  )
                                ),

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                              ),

                              SizedBox(height: 20.r,),

                              //password
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _isObscure,
                                cursorColor: const Color(0xFF3D424A),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF3D424A)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                                  ),
                                  suffixIcon: IconButton(
                                    color: const Color(0xFF3D424A),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = ! _isObscure;
                                      });
                                    },
                                    icon: _isObscure ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off) ,
                                  ) 
                                ),

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter password";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                              ),

                              SizedBox(height: 20.r,),

                              //Login button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  MaterialButton(
                                    height: 50.r,
                                    minWidth: 100.r,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()){
                                        //validated the text field and adds to the firebase, pass to register view model
                                        _formKey.currentState!.save();
                                      }
                                      else {
                                        Navigator.pushReplacementNamed(context, '/home');
                                      }
                                    },
                                    color: const Color(0xFF3D424A),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 14.r,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.r
                                      ),
                                    ),
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

                SizedBox(height: 20.r,),

                //Registration link
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        }, 
                        child: Text(
                          "Register Account",
                          style: TextStyle(
                            fontSize: 14.r,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3D424A)
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                  
                        }, 
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 14.r,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3D424A)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        
              ]
            ),
          ),
        ),
      ),
    );
    
  }
}