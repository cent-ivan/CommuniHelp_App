import 'package:communihelp_app/Databases/FirebaseServices/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassView extends StatefulWidget {
  const ForgotPassView({super.key});

  @override
  State<ForgotPassView> createState() => _ForgotPassViewState();
}

class _ForgotPassViewState extends State<ForgotPassView> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  AuthService _auth = AuthService();

  final oldEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ForgotPasswordAppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Container(
          height: 480.r,
          width: 300.r,
          padding: EdgeInsets.all(12).r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8).r,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter your email to send a reset password link",
                    style: TextStyle(
                      fontSize: 18.r,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              
                  SizedBox(height: 12.r,),

                  //old email input
                  TextFormField(
                    controller: oldEmailController,
                    cursorColor: Theme.of(context).colorScheme.outline,
                      style: TextStyle(
                      fontSize: 20.r
                    ),
                    decoration: InputDecoration(
                      hintText: "Your email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.r, color: Theme.of(context).colorScheme.outline),
                        borderRadius: BorderRadius.circular(8).r
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.r, color: Theme.of(context).colorScheme.outline),
                        borderRadius: BorderRadius.circular(12).r
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.r, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(12).r
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.r, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(12).r
                      ),
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

                  SizedBox(height: 16.r,),


              
                  SizedBox(height: 20.r,),

                  //Save and clear button
                  Row(
                    children: [
                      //UPLOAD
                      MaterialButton(
                        height: 30.r,
                        minWidth: 45.r,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.r))
                        ),
                        color: Color(0xFFFEAE49),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _auth.sendPasswordResetEmail(context, oldEmailController.text);
                            setState(() {
                              oldEmailController.clear();
                            });

                       
                          }
                        },
                        child: Text(
                          "SEND",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.r,
                            color: Theme.of(context).colorScheme.outline
                          ),
                        ),
                      ),

                      SizedBox(width: 12.r,),

                    ],
                  )
                ],
              
              
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//APP BAR--------------------------------------------------------------------------------------
class ForgotPasswordAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ForgotPasswordAppBar ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
        "Forgot Password",
        style: TextStyle(
          color: Theme.of(context).colorScheme.outline,
          fontSize: 20.r,
          fontWeight: FontWeight.bold
        ),
      ),
    
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20.r,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}