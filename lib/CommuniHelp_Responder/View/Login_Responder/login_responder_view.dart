import 'package:communihelp_app/CommuniHelp_Responder/ViewModel/auth_responder.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../auth_director.dart';

class LoginResponderView extends StatefulWidget {
  const LoginResponderView({super.key});

  @override
  State<LoginResponderView> createState() => _LoginResponderViewState();
}

class _LoginResponderViewState extends State<LoginResponderView> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  //Dialogs
  final GlobalDialogUtil _messageDialog = GlobalDialogUtil();

  final double _loginHeight = 350.r;

  bool _isObscure =  true;

  //controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //access view model
  final AuthResponder _authResponder = AuthResponder();

  @override
  Widget build(BuildContext context) {
    final director =  Provider.of<Director>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: 490.r,
          height: 755.r,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/LoginResponder.jpg'),
              fit: BoxFit.cover
            ),
          ),
        
          child: Padding(
            padding: const EdgeInsets.fromLTRB(3, 30, 3, 8).r,
            child: Column(
              children: [
                //Logo and title 
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200.r,
                      child: const Image(
                        image: AssetImage('assets/images/logo/communiHelpLogo.png')
                      ),
                    ),

                    //Logo and title
                    Positioned(
                      top: 140.r,
                      child: Text(
                        "CommuniHelp",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26.r,
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
                      top: 180.r,
                      child: Text(
                        "RESPONDERS AND VOLUNTEERS",
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
                
                SizedBox(height: 30.r,),
        
                //Login box
                Container(
                  height: _loginHeight,
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
                              //email
                              TextFormField(
                                controller: _emailController,
                                style: TextStyle(
                                  color: Color(0xFF3D424A),
                                  fontWeight: FontWeight.bold
                                ),
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

                              SizedBox(height: 20.r,),

                              //password
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _isObscure,
                                style: TextStyle(
                                  color: Color(0xFF3D424A),
                                ),
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
                                      _authResponder.logInEmailPassword(context, "power@gmail.com", "123456");
                                      // if (_formKey.currentState!.validate()){
                                      //   //validated the text field and adds to the firebase, pass to register view model
                                      //   _formKey.currentState!.save();
                    
                                      //   _authResponder.logInEmailPassword(context, "sample@gmail.com", "qwerty");
                                      // }
                                      // else {
                                      //   setState(() {
                                      //     _loginHeight = 358.r;
                                
                                      //   });
                                      // }
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
                              ),

                              SizedBox(height: 35.r,),


                              TextButton(
                                onPressed: () {
                                  director.changeDirection();
                                  //Navigator.pop(context);
                                }, 
                                child: Text(
                                  "BACK TO USER LOGIN",
                                  style: TextStyle(
                                    fontSize: 14.r,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline ,
                                    color: const Color(0xFF3D424A)
                                  ),
                                ),
                              ),
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
                          registerPassword(context);
                          
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
                          Navigator.pushNamed(context, '/forgotpassword');
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

    void registerPassword(BuildContext context) {

    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          title: Text("Enter Password"),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            ),
            cursorColor: Theme.of(context).colorScheme.outline,
            decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.outline
            ),
            enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
            ),
            focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
            ),
            ),
                  
            
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (passwordController.text == "REGISTER"){
                  Navigator.popAndPushNamed(context, '/responderregister');
                }
                else {
                  _messageDialog.unknownErrorDialog(context, "Wrong Password");
                }
              }, 
              child: Text(
                "Enter",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16.r
                ),
              )
            ),
        
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16.r
                ),
              )
            ),
          ],
        );
      }
    );
  }
}