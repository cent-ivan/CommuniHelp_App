import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  final oldEmailController = TextEditingController();
  final passwrodController = TextEditingController();
  final newPassController = TextEditingController();

  bool _isObscure1 =  true;
  bool _isObscure2 =  true;

  //show current user
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: ChangePasswordAppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Container(
          height: 480.r,
          width: 300.r,
          padding: EdgeInsets.all(12).r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8).r,
            color: Theme.of(context).colorScheme.secondary
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter old email",
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
                      hintText: "Your old email",
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

                  Text(
                    "Enter password",
                    style: TextStyle(
                      fontSize: 18.r,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              
                  SizedBox(height: 12.r,),

                  //password input
                  TextFormField(
                    controller: passwrodController,
                    obscureText: _isObscure1,
                    cursorColor: Theme.of(context).colorScheme.outline,
                      style: TextStyle(
                      fontSize: 20.r
                    ),
                    decoration: InputDecoration(
                      hintText: "Your password",
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
                        return "Please enter password";
                      }
                      else{
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 32.r,),


                  Text(
                    "Enter NEW password",
                    style: TextStyle(
                      fontSize: 18.r,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              
                  SizedBox(height: 12.r,),

                  //new password input
                  TextFormField(
                    controller: newPassController,
                    obscureText: _isObscure2,
                    cursorColor: Theme.of(context).colorScheme.outline,
                      style: TextStyle(
                      fontSize: 20.r
                    ),
                    decoration: InputDecoration(
                      hintText: "Your new password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.r, color: const Color(0xFF57BEE6)),
                        borderRadius: BorderRadius.circular(8).r
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.r, color: const Color(0xFF57BEE6)),
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
                        return "Please enter password";
                      }
                      else{
                        return null;
                      }
                    },
                  ),

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
                            
                            viewModel.updatePassword(user.uid, oldEmailController.text, passwrodController.text, newPassController.text, context);
                            setState(() {
                              oldEmailController.clear();
                              passwrodController.clear();
                              newPassController.clear();
                            });

                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "UPDATE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.r,
                            color: Theme.of(context).colorScheme.outline
                          ),
                        ),
                      ),

                      SizedBox(width: 12.r,),

                      //CLEAR
                      MaterialButton(
                        height: 30.r,
                        minWidth: 45.r,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.r))
                        ),
                        color: Color(0xFF57BEE6),
                        onPressed: () {
                          setState(() {
                            oldEmailController.clear();
                            passwrodController.clear();
                            newPassController.clear();
                          });
                        },
                        child: Text(
                          "CLEAR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.r,
                            color: Theme.of(context).colorScheme.outline
                          ),
                        ),
                      ),
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
class ChangePasswordAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ChangePasswordAppBar ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
        "Change Password",
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