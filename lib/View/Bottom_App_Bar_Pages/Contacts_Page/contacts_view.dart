import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/contacts_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}


class _ContactsViewState extends State<ContactsView> {
  Logger logger = Logger(); //diplay debug messages
  //access dialogs
  GlobalDialogUtil dialogs = GlobalDialogUtil();
  
  final viewModel = ContactsViewModel();
  bool isEditMode = false; //switch from text to text field

  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;
  
  
  @override
  Widget build(BuildContext context) {
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage); //catches aklanon language to replace with filipino
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Container(
          padding: EdgeInsets.fromLTRB(12, 0, 16, 12),
          child: SingleChildScrollView(
            child: Consumer<ContactsViewModel>(builder: (context, viewModel, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36.r,),
                Text(
                  languageClass.systemLang["Contact"]["Label"],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 24.r,
                    fontWeight: FontWeight.bold
                  ),
                ),
            
                SizedBox(height: 16.r,),
            
                //Search bar
                TextField(
                  onTap: () {   
                    Navigator.pushNamed(context, '/searchcontact');
                  },
                  readOnly: true,
                  style: TextStyle(
                    fontSize: 18.r,
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.bold
                  ),
                  cursorColor: Theme.of(context).colorScheme.outline,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: languageClass.systemLang["Contact"]["Search"],
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontStyle: FontStyle.italic
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12).r,
                      borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12).r,
                      borderSide: BorderSide(width: 1.5.r, color: Theme.of(context).colorScheme.outline)
                    )
                  ),
                ),
            
                SizedBox(height: 16.r,),
                    
                //List of contacts
                SizedBox(
                  height: 375.r,
                  width: 295.r,
                  child: ListView.builder(
                    itemCount: viewModel.dbContact.contacts.length,
                    itemBuilder: (context, i) {
                      //List tile of contacts
                      return GestureDetector(
                        onTap: () {
                          showContactDetails(i);
                        },
                        child: Container(
                          height: 75.r,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8).r
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8.r),
                          padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8).r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Name and number
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                   viewModel.dbContact.contacts[i]["Name"].toString(),
                                    style: TextStyle(
                                      fontSize: 20.r,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 4.r,),
                                  Text(
                                    viewModel.dbContact.contacts[i]["Contact"].toString()
                                  ),
                                ],
                              ),

                              IconButton(
                                onPressed: () async {
                                  final Uri url = Uri(
                                    scheme: 'tel',
                                    path: viewModel.dbContact.contacts[i]["Contact"],
                                  );
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  }
                                  else {
                                    if (context.mounted) {
                                      dialogs.unknownErrorDialog(context, "Cannot be launched");
                                    }
                                    else {
                                      logger.e("Cannot be launch");
                                    }
                                  }
                                }, 
                                icon: Icon(Icons.call, color: Color(0xFF57BEE6), size: 35.r,)
                              )
                              
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                )


              ],
            ),
          )
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: ContactFloatingActionButton(),
      ),
    );
  }



  //show details of contact
  void showContactDetails(int index) {
    viewModel.editNameController.text = viewModel.dbContact.contacts[index]["Name"];
    viewModel.editNumberController.text = viewModel.dbContact.contacts[index]["Contact"];

    showDialog(context: context, 
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          contentPadding: EdgeInsets.all(12).r,
          children: [
            Column(
              children: [
                //edit name and delete row
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Contact info column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //if edit mode shpw text box
                          isEditMode ? SizedBox(
                            width: 150.r,
                            child: TextField(
                              controller: viewModel.editNameController,
                              decoration: InputDecoration(
                                hintText: viewModel.dbContact.contacts[index]["Name"].toString(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                                )
                              ),
                  
                            ),
                          ) :
                          //shows the name 
                          Text(
                            viewModel.dbContact.contacts[index]["Name"].toString(),
                            style: TextStyle(
                                fontSize: 28.r,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                  
                          SizedBox(width: 16.r,),

                          isEditMode ? SizedBox(
                            width: 150.r,
                            child: TextField(
                            controller: viewModel.editNumberController,
                              decoration: InputDecoration(
                                  hintText: viewModel.dbContact.contacts[index]["Contact"].toString(),
                                  enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                                )
                              ),
                            ),
                          ) :
                              //shows the name 
                          Text(
                            viewModel.dbContact.contacts[index]["Contact"].toString(),
                            style: TextStyle(
                                fontSize: 16.r,
                            ),
                          ),
                  
                        ],
                      ),

                    

                      //if edit mode show text box
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //CHECK changes
                          isEditMode ? Container(
                            margin: EdgeInsets.only(left: 24.r),
                            child: IconButton(
                              //shows in check if edit mode
                              onPressed: () {
                                //if both
                                if (viewModel.editNameController.text.isNotEmpty && viewModel.editNumberController.text.isNotEmpty) {
                                  
                                  viewModel.changeName(index);
                                  viewModel.changeContact(index);
                                  viewModel.updateDB(curUser!.uid);
                                  viewModel.loadDB(curUser!.uid);
                                  setState(() {
                                    isEditMode = false;
                                  });
                                  Navigator.pop(context);
                                      
                                }
                                //if name only
                                else if (viewModel.editNameController.text.isNotEmpty) {
                                  
                                  viewModel.changeName(index);
                                  viewModel.updateDB(curUser!.uid);
                                  setState(() {
                                    isEditMode = false;
                                  });
                                  Navigator.pop(context);
                                
                                }
                                //if number only
                                else if (viewModel.editNumberController.text.isNotEmpty) {
                                  
                                  viewModel.changeContact(index);
                                  viewModel.updateDB(curUser!.uid);
                                  setState(() {
                                    isEditMode = false;
                                  });
                                  Navigator.pop(context);
                              
                                }
                                          
                                else {  
                                  setState(() {
                                    isEditMode = false;
                                  });
                                  //exits if all empty
                                  Navigator.pop(context);
                                }
                              
                              },
                               icon: Icon(Icons.check, color: Colors.green,)
                            ),
                          ) :    
                          IconButton(
                            //shows pencil if not in edit mode
                            onPressed: () {
                              setState(() {
                                isEditMode = true;
                              });
                              Navigator.pop(context);
                              showContactDetails(index);
                            
                            },
                             icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.outline,)
                          ),
                      
                          
                          //DELETE a contact
                          isEditMode ? IconButton(
                            onPressed: () {
                              setState(() {
                                viewModel.deleteContact(index, curUser!.uid);
                              });
                              

                              Navigator.pop(context);
                            }, 
                            icon: Icon(Icons.delete, color: Colors.redAccent,)
                          ) : Text(""),
                        
                          
                        ],
                      ),
                  
  
                      
                    ],
                  ),
                ),

                SizedBox(height: 24.r,),

                //Call and cancel button
                SizedBox(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                            height: 25.r,
                            minWidth: 40.r,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.r))
                            ),
                            color: Color(0xFFFEAE49),
                            disabledColor: Colors.grey,
                            onPressed: isEditMode ? null : ()  async {
                              //direct to call app of phone
                              final Uri url = Uri(
                                scheme: 'tel',
                                path: viewModel.dbContact.contacts[index]["Contact"],
                              );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                                else {
                                  if (context.mounted) {
                                    dialogs.unknownErrorDialog(context, "Cannot be launched");
                                  }
                                else {
                                  logger.e("Cannot be launch");
                                }
                              }
                            },
                            child: Text(
                              "CALL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.r,
                                color: Theme.of(context).colorScheme.outline
                              ),
                            ),
                          ),
                  
                        SizedBox(width: 5.r,),
                  
                        //cancel
                        MaterialButton(
                            height: 25.r,
                            minWidth: 40.r,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.r))
                            ),
                            color: Color(0xFF57BEE6),
                            onPressed: () {
                              setState(() {
                                isEditMode = false;
                              });
                              Navigator.pop(context);       
                              
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.r,
                                color: Theme.of(context).colorScheme.outline
                              ),
                            ),
                          ),
                      ],
                  ),
                )
              ],
            )
          ],
        );
      }
    );
  }

}


//Floating Action Button-------------------------------------------------------------------------
class ContactFloatingActionButton extends StatefulWidget {
  const ContactFloatingActionButton({
    super.key,
  });

  @override
  State<ContactFloatingActionButton> createState() => _ContactFloatingActionButtonState();
}

class _ContactFloatingActionButtonState extends State<ContactFloatingActionButton> {
  //show current user
  User? curUser = FirebaseAuth.instance.currentUser;

  final dialog = GlobalDialogUtil();

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(40.r),
      child: FloatingActionButton(
        heroTag: 'addContactHero',
        onPressed: () {
          addContact();
          
        },
        backgroundColor: Color(0xFF57BEE6),
        foregroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 25.r,
        ),
      ),
    );
  }

  void addContact() {
    showDialog(context: context, 
      builder: (context) {
        return SimpleDialog(
          title: Text("Add Contact"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          contentPadding: EdgeInsets.all(12).r,
          children: [
            //content of the add contact
            Consumer<ContactsViewModel>(builder: (context, viewModel, child) => Column(
              children: [
                SizedBox(
                    width: 250.r,
                    child: TextField(
                      controller: viewModel.editNameController,
                      decoration: InputDecoration(
                      hintText: "Enter name",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                      ),
                  ),
            
                  ),
                ),

                SizedBox(height: 16.r,),

                //Add number
                SizedBox(
                    width: 250.r,
                    child: TextField(
                      controller: viewModel.editNumberController,
                      decoration: InputDecoration(
                      hintText: "Enter  number",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1.r, color: Theme.of(context).colorScheme.outline)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                      ),
                    ),
            
                  ),
                ),

                SizedBox(height: 32.r,),

                //Buttons
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      height: 25.r,
                      minWidth: 40.r,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.r))
                      ),
                      color: Color(0xFFFEAE49),
                      disabledColor: Colors.grey,
                      onPressed: ()  {
                        if (viewModel.editNumberController.text.isEmpty) {
                          dialog.errorDialog(context, "Enter a number");
                        } 
                        else {
                          viewModel.addToContact();
                          viewModel.loadDB(curUser!.uid);
                        }
                        
                        
                        Navigator.pop(context);
                      },
                      child: Text(
                        "ADD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.r,
                          color: Theme.of(context).colorScheme.outline
                        ),
                      ),
                    ),
            
                    SizedBox(width: 5.r,),
            
                    //cancel
                    MaterialButton(
                      height: 25.r,
                      minWidth: 40.r,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.r))
                      ),
                      color: Color(0xFF57BEE6),
                      onPressed: () {
                        viewModel.editNameController.clear();
                        viewModel.editNumberController.clear();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
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
            )
          )
          ],
        );
      }
    );
  }
}