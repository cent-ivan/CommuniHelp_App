import 'package:communihelp_app/View/Infographics/Natural_Disaster/landslide/landslide_pages.dart';
import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';
import 'package:communihelp_app/ViewModel/Settings_View_Models/user_setting_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LandslideView extends StatefulWidget {
  const LandslideView({super.key});

  @override
  State<LandslideView> createState() => _LandslideViewState();
}

class _LandslideViewState extends State<LandslideView> {
  int _currentPage = 0; //shows the index of the current page
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    //show current user
    User? curUser = FirebaseAuth.instance.currentUser;
    final settings = UserSettingViewModel();
    settings.loadSettings(curUser!.uid);
    var languageClass = Language(settings.userLanguage);

    final viewModel = Provider.of<NaturalDisasterViewModel>(context);
    final pages = Provider.of<LandslidePages>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEFEFEF),
        elevation: 1,
        title: Text(
             languageClass.systemLang["NaturalInfo"]["LandButton"],
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
                    _currentPage != pages.getList(settings.userLanguage.toUpperCase(), viewModel).length - 1 ?
                    _controller.animateToPage( //animates the switching of page
                      _currentPage += 1, 
                      duration: Duration(milliseconds: 600), 
                      curve: Curves.easeIn
                    ) : 
                    Navigator.pop(context);
                  },
                  child: Text(
                    _currentPage != pages.getList(settings.userLanguage.toUpperCase(), viewModel).length -1  ?
                    languageClass.systemLang["NaturalInfo"]["Next"]
                    : languageClass.systemLang["NaturalInfo"]["Finish"],
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