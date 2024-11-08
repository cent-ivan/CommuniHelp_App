import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/contacts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final viewModel = ContactsViewModel();
  Logger logger = Logger(); //diplay debug messages
  //access dialogs
  GlobalDialogUtil dialogs = GlobalDialogUtil();
  
  bool isEditMode = false; //switch from text to text field

  List<dynamic> tempContacts = [];

  @override
  void initState() {
    super.initState();
    tempContacts = viewModel.dbContact.contacts;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Search ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.outline
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16).r,
        child: SingleChildScrollView(
          child:  Column(
              children: [
            
                SizedBox(height: 16.r,),
            
                //Search bar
                TextField(
                  onChanged: (value) => filterContacts(value),
                  style: TextStyle(
                    fontSize: 18.r,
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.bold
                  ),
                  cursorColor: Theme.of(context).colorScheme.outline,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search",
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
                  height: 600.r,
                  width: 350.r,
                  child: ListView.builder(
                    itemCount: tempContacts.length,
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
                                   tempContacts[i]["Name"].toString(),
                                    style: TextStyle(
                                      fontSize: 20.r,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 4.r,),
                                  Text(
                                    tempContacts[i]["Contact"].toString()
                                  ),
                                ],
                              ),

                              IconButton(
                                onPressed: () async {
                                  final Uri url = Uri(
                                    scheme: 'tel',
                                    path: tempContacts[i]["Contact"],
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
          
        ),
      ),
    );
  }

  //filters the contact list as txt xhanges
  void filterContacts(String keyword) {
    List<dynamic> results = [];
    if (keyword.isEmpty) {
      results = viewModel.dbContact.contacts;
    }
    else {
      //checks if the name in each map contains the keyword
      results = tempContacts
      .where((data) => data["Name"].toLowerCase().contains(keyword.toLowerCase()))
      .toList();
    }

    setState(() {
      tempContacts = results;
    });
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
                                  viewModel.updateDB();
                                  viewModel.loadDB();
                                  setState(() {
                                    isEditMode = false;
                                  });
                                  Navigator.pop(context);
                                      
                                }
                                //if name only
                                else if (viewModel.editNameController.text.isNotEmpty) {
                                  
                                  viewModel.changeName(index);
                                  viewModel.updateDB();
                                  setState(() {
                                    isEditMode = false;
                                  });
                                  Navigator.pop(context);
                                
                                }
                                //if number only
                                else if (viewModel.editNumberController.text.isNotEmpty) {
                                  
                                  viewModel.changeContact(index);
                                  viewModel.updateDB();
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
                              viewModel.deleteContact(index);
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