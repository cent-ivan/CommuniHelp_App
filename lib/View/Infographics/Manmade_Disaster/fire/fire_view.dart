import 'package:communihelp_app/View/Infographics/Manmade_Disaster/fire/fire_pages.dart';
import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/manmade_dis_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FireView extends StatefulWidget {
  const FireView({super.key});

  @override
  State<FireView> createState() => _FireViewState();
}

class _FireViewState extends State<FireView> {
  int _currentPage = 0; //shows the index of the current page
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    //show current user
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);
    
    final viewModel = Provider.of<ManMadeDisasterViewModel>(context);
    final pages = Provider.of<FirePages>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEFEFEF),
        elevation: 1,
        title: Text(
             languageClass.systemLang["ManmadeInfo"]["Fire"],
            style: TextStyle(
              color: Color(0xFF3D424A),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
            
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/images/infographics/exit_button.png', height: 35, width: 35,),
        )
      ),

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },

        children: pages.getList(settings.userLanguage.toUpperCase(), viewModel).map((infoPath) {
          return SingleChildScrollView(
            child: InteractiveViewer(
                  //for zoom
                  minScale: 0.5,
                  maxScale: 8,
                  child: Image(
                    image: AssetImage(infoPath),
                    fit: BoxFit.fitWidth,
                  )
                ),
          );
        }).toList(),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFEFEFEF),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _controller.animateToPage( //animates the switching of page
                      _currentPage -= 1, 
                      duration: Duration(milliseconds: 600), 
                      curve: Curves.easeIn
                    );
                },
                child: Image.asset('assets/images/infographics/left-arrow.png', height: 35, width: 35,)
              ),
          
              SizedBox(
                width: 100,
                child: MaterialButton(
                  elevation: 0,
                  color: Color(0xFFFEAE49),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.r))
                  ),
                  onPressed: () {
                    _controller.animateToPage( //animates the switching of page
                      _currentPage += 1, 
                      duration: Duration(milliseconds: 600), 
                      curve: Curves.easeIn
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Color(0xFF3D424A),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
      
    );
  }
}