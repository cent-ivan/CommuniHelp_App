import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutAppView extends StatefulWidget {
  const AboutAppView({super.key});

  @override
  State<AboutAppView> createState() => _AboutAppViewState();
}

class _AboutAppViewState extends State<AboutAppView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
        title: Text(
          "About App",
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
        
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          height: 1140.r,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.r,),
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo/communiHelpLogo.png'),
                  width: 170,
                  height: 170,
                ),
              ),
          
              Image(
                image: AssetImage('assets/images/logo/label.png'),
                width: 380,
                height: 80,
              ),
        
              SizedBox(height: 32,),
        
              Text(
                "What is CommuniHelp?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.r,
                  color: Theme.of(context).colorScheme.outline
                ),
              ),
        
              SizedBox(height: 20,),
        
              Container(
                padding: EdgeInsets.all(16).r,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  """CommuniHelp, a disaster preparedness assistance and utility mobile application that will provide both information resource, a utility app specific for disaster preparedness, and improve disaster preparedness literacy of civilians. Made by fourth year students of Aklan State University, Bachelor of Science in Information Technology - Software Engineering.
        
        This application can help disseminate information about safety before, during, and after a disaster. This mobile application can also provide a communication channel for dissemination of updates and information for a wider scope. It has features like locating and getting directions to evacaution centers and have a many more features that can help a civilian in disaster preparedness.""",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 12.r
                  ),
                ),
              ),

              SizedBox(height: 42,),
        
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "The team behind the app:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.r,
                        color: Theme.of(context).colorScheme.outline
                      ),
                    ),
                
                    Text(
                      "Our Team",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.r,
                        color: Color(0xFF01579B)
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24,),

              Container(
                margin: EdgeInsets.only(bottom: 20.r),
                padding: EdgeInsets.all(16).r,
                width: 300.r,
                decoration: BoxDecoration(
                  color: Color(0xFFADADAD),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "Vincent Ivan Palomata",
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D424A)
                      ),
                    ),

                    Text(
                      "Project Manager/Lead Developer",
                      style: TextStyle(
                        fontSize: 12.r,
                        color: Color(0xFF3D424A)
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 16.r),
                padding: EdgeInsets.all(16).r,
                width: 300.r,
                decoration: BoxDecoration(
                  color: Color(0xFFADADAD),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "Diorj Hendrix Vicencio",
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D424A)
                      ),
                    ),

                    Text(
                      "Quality Assurance/Programmer/Researcher",
                      style: TextStyle(
                        fontSize: 12.r,
                        color: Color(0xFF3D424A)
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 16.r),
                padding: EdgeInsets.all(16).r,
                width: 300.r,
                decoration: BoxDecoration(
                  color: Color(0xFFADADAD),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "Zam Cassey Estores",
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D424A)
                      ),
                    ),

                    Text(
                      "Programmer/System Analyst",
                      style: TextStyle(
                        fontSize: 12.r,
                        color: Color(0xFF3D424A)
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 16.r),
                padding: EdgeInsets.all(16).r,
                width: 300.r,
                decoration: BoxDecoration(
                  color: Color(0xFFADADAD),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "Christian Joy David",
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D424A)
                      ),
                    ),

                    Text(
                      "UI Designer/Researcher",
                      style: TextStyle(
                        fontSize: 12.r,
                        color: Color(0xFF3D424A)
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}