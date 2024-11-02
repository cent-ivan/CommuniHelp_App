import 'package:communihelp_app/Model/forum_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Databases/FirebaseServices/FirestoreServices/get_forum.dart';
import '../../../Databases/FirebaseServices/FirestoreServices/get_user_data.dart';

class PostDialog {
  //form global key
  final _formKey = GlobalKey<FormState>();

  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();

  final firestoreForum = GetForum();

  void addPost(BuildContext context) {
    final userData = Provider.of<GetUserData>(context, listen: false);
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) {
        return SizedBox(
          height: 500.r,
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text("Magbahagi ng saloobin", style: TextStyle(fontWeight: FontWeight.bold),),
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              content: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Divider(),
                            
                            
                    //content
                    Padding(
                      padding: const EdgeInsets.all(9).r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //User name
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: Colors.black,
                                ),
                              ),
                                    
                              Text(
                                "${userData.name}, taga-${userData.barangay}"
                              ),
                            ],
                          ),
                
                          SizedBox(
                            width: 200.r,
                            child: TextFormField(
                              controller: title,
                              style: TextStyle(
                                fontSize: 16.r
                              ),
                              decoration: InputDecoration(
                                hintText: 'Pamagat ng iyong post ',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 3,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Maglagay ng pamagat";
                                }
                                return null;
                              },
                            ),
                          ),
                              
                          SizedBox(height: 15.r,),
                
                      
                          SizedBox(
                            width: 1500.r,
                            child: TextFormField(
                              controller: content,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Ano ang iyong gustong ibahagi?',
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic
                                )
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Blangko ang iyong post";
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                
                  ],
                ),
              ),
                    
              actions: [
                TextButton(
                  child: Text(
                    'I-post',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 16.r
                    ),
                  ),
                  onPressed: () {
                    final dateNow = DateTime.now();
                    final timeNow = DateFormat.jm();
                    String formattedDate = "${dateNow.day}/${dateNow.month}/${dateNow.year}, $timeNow";

                    if (_formKey.currentState!.validate()) {
                      firestoreForum.postForum(userData.municipality, ForumModel(
                        name: userData.name, 
                        barangay: userData.barangay, 
                        title: title.text, 
                        content: content.text, 
                        type: "responder", 
                        date: formattedDate, 
                        presses: [{userData.name : false}], 
                        likes: 0,
                        profileURL: userData.userProfURL
                        )
                      );

                      Navigator.pop(context);
                    }
                  },
                ),

                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 16.r
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}