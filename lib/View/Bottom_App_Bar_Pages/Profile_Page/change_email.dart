import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  final oldEmailController = TextEditingController();
  final passwrodController = TextEditingController();
  final newEmailController = TextEditingController();


  //show current user
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: ChangeEmailAppBar(),
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
                    "Enter NEW email",
                    style: TextStyle(
                      fontSize: 18.r,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              
                  SizedBox(height: 12.r,),

                  //new email input
                  TextFormField(
                    controller: newEmailController,
                    cursorColor: Theme.of(context).colorScheme.outline,
                      style: TextStyle(
                      fontSize: 20.r
                    ),
                    decoration: InputDecoration(
                      hintText: "Your new email",
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

                            viewModel.updateEmail(user.uid, oldEmailController.text, passwrodController.text, newEmailController.text, context);
                            setState(() {
                              oldEmailController.clear();
                              passwrodController.clear();
                              newEmailController.clear();
                            });
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
                            newEmailController.clear();
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
class ChangeEmailAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ChangeEmailAppBar ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
        "Change Email",
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