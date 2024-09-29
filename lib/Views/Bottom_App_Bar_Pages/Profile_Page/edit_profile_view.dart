import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/ViewModels/Home_View_Models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String currentOption = options[0];
  
  double _screenSize = 895.r + 130.r;
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
            height: _screenSize,
            padding: const EdgeInsets.fromLTRB(12, 25, 12, 5).r,
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
                          splashRadius: 50.r,
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
                Container(
                  padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                    color:  const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))
                  ),
                  child: Form(
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
                            controller: viewModel.nameController,
                            cursorColor: const Color(0xFF3D424A),
                            style: TextStyle(
                              fontSize: 14.r
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
                            controller: viewModel.birthdateController,
                            cursorColor: const Color(0xFF3D424A),
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 14.r
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
                                  viewModel.pickDate(context);
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

                          //gender
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
                          Wrap(
                            spacing: 4.r,
                            runSpacing: 4.r,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                    
                                  StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance.collection('municipalities').snapshots(), 
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Center(child: Text("Error occured: ${snapshot.error}"),);
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
                                                      fontSize: 12.r
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
                                                height: 2,
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
                  
                                ],
                              ),

                              SizedBox(height: 3.r,),
                    
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                    
                                  StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance.collection('municipalities').doc(viewModel.municipalId).collection('Cities').snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Center(child: Text("Error occured: ${snapshot.error}"),);
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
                                                      fontSize: 12.r
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
                                                  color: viewModel.isActive? const Color(0xFF3D424A) : const Color(0xFF808080)
                                                )
                                              ),
                                              value: viewModel.barangayId,
                                              items: viewModel.isActive? barangays : null, 
                                              iconSize: 28.r,
                                              underline: Container(
                                                height: 2,
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
                    
                              SizedBox(width: 10.r,)
                            ],
                          ),
                    
                          SizedBox(height: 40.r,),
                    
                          //Contact Number
                          Text(
                            "Contact Details",
                            style: TextStyle(
                              color: const Color(0xFFFEAE49),
                              fontSize: 20.r,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                    
                          SizedBox(height: 10.r,),
                  
                          Text(
                            "Email",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 14.r,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                  
                          SizedBox(height: spaceBetweenLabel,),
                  
                          //edit email
                          TextFormField(
                            controller: viewModel.emailController,
                            cursorColor: const Color(0xFF3D424A),
                            style: TextStyle(
                              fontSize: 18.r
                            ),
                            decoration: InputDecoration(
                              hintText: "Edit Email",
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
                  
                  
                          SizedBox(height: spaceBetweenDetails,),
                  
                          Text(
                            "Mobile number",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 14.r,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                    
                          SizedBox(height: spaceBetweenLabel,),
                  
                          //edit contacts
                          TextFormField(
                            controller:  viewModel.contactController,
                            cursorColor: const Color(0xFF3D424A),
                            maxLength: 11,
                            keyboardType: TextInputType.number, //accepts only intgers
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
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
                  
                          //Save Button
                          MaterialButton( 
                            onPressed: (){
                              if (_formKey.currentState!.validate() && viewModel.barangayValue != null){
                                  //validated the text field and adds to the firebase, pass to register view model
                                  _formKey.currentState!.save();
                                  setState(() {
                                    _screenSize = 895.r + 130.r;
                                  });
                    
                                  //calls update
                                  viewModel.updateProfile(
                                    viewModel.nameController.text, 
                                    viewModel.birthdateController.text, 
                                    currentOption, 
                                    viewModel.barangayValue!, 
                                    viewModel.municipalityValue!, 
                                    viewModel.emailController.text,
                                    viewModel.contactController.text
                                    
                                  );
                                  Navigator.pushReplacementNamed(context, '/home');
                              }
                              else if (viewModel.barangayValue == null || viewModel.municipalityValue ==  null) {
                                //edit the design
                                showDialog(
                                  context: context, 
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: const Color(0xFFDFB6B2),
                                      title: const Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.white,
                                          ),

                                          SizedBox(width: 8,),

                                          Text("Catched Error"),
                                        ],
                                      ),
                                      titleTextStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),

                                      contentPadding: const EdgeInsets.only(left: 2),
                                      content: Container(
                                        padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                                        height: 95,
                                        child: const Text(
                                          "You didnt put barangay boi",
                                          style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      ),
                                    );
                                  },
                                );
                              }
                              else {
                                setState(() {
                                  _screenSize = _screenSize + 70.r;
                                });
                              }
                              
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
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }

  
}