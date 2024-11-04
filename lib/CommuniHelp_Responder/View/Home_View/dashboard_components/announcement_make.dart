import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnnouncementMake extends StatefulWidget {
  const AnnouncementMake({super.key});

  @override
  State<AnnouncementMake> createState() => _AnnouncementMakeState();
}

class _AnnouncementMakeState extends State<AnnouncementMake> {
  //form global key
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool isUrgent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnnouncementAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16).r,
        child: SizedBox(
              height: 800.r,
              width: 500.r,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                      style: TextStyle(
                        fontSize: 18.r,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline
                      ),
                    ),

                    SizedBox(height: 20.r,),


                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline
                      ),
                    ),
        
                    SizedBox(height: 10.r,),
        
                    //Title Text Field
                    SizedBox(
                      height: 50.r,
                      width: 450.r,
                      child: TextFormField(
                        controller: _titleController,
                        style: TextStyle(
                            fontSize: 16.r,
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.bold
                          ),
                          cursorColor: Theme.of(context).colorScheme.outline,
                          decoration: InputDecoration(
                          hintText: "Enter Title",
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontStyle: FontStyle.italic
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8).r,
                            borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                          ),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12).r,
                            borderSide: BorderSide(width: 1.5.r, color: Theme.of(context).colorScheme.outline)
                          )
                        ),
                      ),
                      
                    ),
                    
                    SizedBox(height: 16.r,),
        
                    Text(
                      "Content",
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline
                      ),
                    ),
        
                    SizedBox(height: 10.r,),
        
                    //Content Text Field
                    SizedBox(
                      height: 200.r,
                      width: 450.r,
                      child: TextFormField(
                        controller: _contentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        style: TextStyle(
                            fontSize: 16.r,
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.bold
                          ),
                          cursorColor: Theme.of(context).colorScheme.outline,
                          decoration: InputDecoration(
                          hintText: "Enter announcement content",
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontStyle: FontStyle.italic
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8).r,
                            borderSide: BorderSide(width: 2.r, color: Theme.of(context).colorScheme.outline)
                          ),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12).r,
                            borderSide: BorderSide(width: 1.5.r, color: Theme.of(context).colorScheme.outline)
                          )
                        ),
                      ),
                      
                    ),
        
                    SizedBox(height: 16.r,),
        
                    Text(
                      "Is urgent?",
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline
                      ),
                    ),
        
                    SizedBox(height: 8.r,),
        
                    Switch(
                      inactiveThumbColor: Theme.of(context).colorScheme.outline,
                      activeColor: const Color(0xFFFEAE49),
                      value: isUrgent, 
                      onChanged: (value) {
                        setState(() {
                          isUrgent = value;
                        });
                      }
                    ),

                    SizedBox(height: 24.r,),

                    //Post and Clear Buttons
                    Center(
                      child: Row(
                        children: [
                          MaterialButton(
                              height: 65.r,
                              minWidth: 150.r,
                              onPressed: () {
                                setState(() {
                                  _titleController.clear();
                                  _contentController.clear();
                                  isUrgent = false;
                                });
                              
                                
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.r))
                              ),
                              color: Color(0xFFFEAE49),
                              elevation: 1.r,
                              child: Text(
                                "Post",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.r,
                                  color: Theme.of(context).colorScheme.outline
                                ),
                              ),
                          ),
                      
                          SizedBox(width: 10.r,),
                      
                          MaterialButton(
                              height: 65.r,
                              minWidth: 150.r,
                              onPressed: () {
                                setState(() {
                                  _titleController.clear();
                                  _contentController.clear();
                                  isUrgent = false;
                                });
                              
                                
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.r))
                              ),
                              color: Color(0xFF57BEE6),
                              elevation: 1.r,
                              child: Text(
                                "Clear",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.r,
                                  color: Theme.of(context).colorScheme.outline
                                ),
                              ),
                          ),
                        ],
                      ),
                    )
                  
                  ],
                ),
              ),
            ),
      )
    );
  }

  
}


//APP BAR----------------------------------------------------------------------------------------------------
class AnnouncementAppBar extends StatelessWidget implements PreferredSizeWidget{
  const AnnouncementAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),
          
        child: const Text(
          "Make Announcement",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
          
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}