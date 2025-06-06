import 'package:communihelp_app/CommuniHelp_Responder/ViewModel/auth_responder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/Login_View_Models/login_firebase_view_model.dart';
import '../../../auth_director.dart';

class LoginView extends StatefulWidget {

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Logger logger =  Logger();

  //access view model
  final LoginFirebaseViewModel loginViewModel = LoginFirebaseViewModel();

  //form global key
  final _formKey = GlobalKey<FormState>();

  double _loginHeight = 310.r;

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
          width: 485.r,
          height: 755.r,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/Login.jpg'),
              fit: BoxFit.cover
            ),
          ),
        
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 8).r,
            child: Column(
              children: [
                //Logo and title 
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 230.r,
                      child: const Image(
                        image: AssetImage('assets/images/logo/communiHelpLogo.png')
                      ),
                    ),

                    //Logo and title
                    Positioned(
                      top: 130.r,
                      child: Text(
                        "CommuniHelp",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.r,
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
                      top: 170.r,
                      child: Text(
                        """Disaster Preparedness Asssistance 
and Utility App""",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.r,
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
                                      //loginViewModel.loginUser(context, "sample@gmail.com", "qwerty");
                                      if (_formKey.currentState!.validate()){
                                        //check if user is a responder
                                        if (_emailController.text.contains("LOGIN@HELPER") && _passwordController.text.contains("9112")) {
                                          director.changeDirection();
                                          //Navigator.pushNamed(context, '/responderlogin');
                                        }
                                        else {
                                          //validated the text field and adds to the firebase, pass to register view model
                                          logger.d("called in login");
                                          _formKey.currentState!.save();
                                          loginViewModel.loginUser(context, _emailController.text, _passwordController.text);
                                        }
          
                                      }
                                      else {
                                        setState(() {
                                          _loginHeight = 330.r;
                                        });
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
                                  ),

                                  SizedBox(width: 10,),

                                  MaterialButton(
                                    height: 50.r,
                                    minWidth: 100.r,
                                    onPressed: () {
                                      director.changeDirection();
                                    
                                      
                                    },
                                    color: const Color(0xFF3D424A),
                                    child: Text(
                                      "Responder",
                                      style: TextStyle(
                                        fontSize: 14.r,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.r
                                      ),
                                    ),
                                  ),


                                ],
                              )

                            ],
                          ),
                        ),

                        MaterialButton(
                                    height: 20.r,
                                    minWidth: 80.r,
                                    onPressed: () {
                                      loginViewModel.loginUser(context, "sample@gmail.com", "123456");
                                      // if (_formKey.currentState!.validate()){
                                      //   //check if user is a responder
                                      //   if (_emailController.text.contains("LOGIN@HELPER") && _passwordController.text.contains("9112")) {
                                      //     director.changeDirection();
                                      //     //Navigator.pushNamed(context, '/responderlogin');
                                      //   }
                                      //   else {
                                      //     //validated the text field and adds to the firebase, pass to register view model
                                      //     logger.d("called in login");
                                      //     _formKey.currentState!.save();
                                      //     loginViewModel.loginUser(context, _emailController.text, _passwordController.text);
                                      //   }
          
                                      // }
                                      // else {
                                      //   setState(() {
                                      //     _loginHeight = 330.r;
                                      //   });
                                      // }
                                    },
                                    color: const Color(0xFF3D424A),
                                    child: Text(
                                      "Fast Login",
                                      style: TextStyle(
                                        fontSize: 12.r,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.r
                                      ),
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
                          Navigator.pushNamed(context, '/register');
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
}