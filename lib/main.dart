import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Model/Emergency_kit_model/emergency_kit_model.dart';
import 'package:communihelp_app/ViewModel/Registration_View_Models/registration_view_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/anouncement_view_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/emergency_kit_view_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/emergency_view_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/profile_view_model.dart';
import 'package:communihelp_app/ViewModel/theme.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Profile_Page/edit_profile_view.dart';
import 'package:communihelp_app/View/Login_Registration_Page/Login_Page/login_view.dart';
import 'package:communihelp_app/View/Login_Registration_Page/Registration_Page/registration_view.dart';
import 'package:communihelp_app/View/Utility_Pages/Emergency_Kit/emergency_kit_view.dart';
import 'package:communihelp_app/View/Utility_Pages/Evacuation_Finder/evacaution_finder_view.dart';
import 'package:communihelp_app/View/Infographics/Man_Made_Disaster/manmade_disaster_view.dart';
import 'package:communihelp_app/View/Infographics/Natural_Disaster/natural_disaster_view.dart';
import 'package:communihelp_app/View/Utility_Pages/News_Feed/news_view.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Profile_Page/profile_view.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Emergency_Page/emergency_view.dart';
import 'package:communihelp_app/View/Utility_Pages/Report_Damage/report_damage_view.dart';
import 'package:communihelp_app/View/Utility_Pages/Weather_Page/weather_view.dart';
import 'package:communihelp_app/View/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'ViewModel/Connection_Controller/dependency_injection.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Set preferred orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter(EmergencyKitModelAdapter());

  await Hive.openBox<List>('emergencykit');
  await Hive.openBox<List>('emergencycontact');

  
  runApp(
    MultiProvider(
      providers: [
        //View Model for Pages
        ChangeNotifierProvider(create: ((context) => EmergencyViewModel())),
        ChangeNotifierProvider(create: ((context) => AnnouncementViewModel())),
        ChangeNotifierProvider(create: ((context) => ProfileViewModel())),
        ChangeNotifierProvider(create: ((context) => EmergencyKitViewModel())),

        //View Model for Firestore
        ChangeNotifierProvider(create: ((context) => RegistrationViewModel())),
        ChangeNotifierProvider(create: ((context) => GetUserData())),
      ],
      child: const MainApp(),
    )
  );

  DependencyInjection.init();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {

    return  ScreenUtilInit(
      
      builder: (context, child) => GetMaterialApp(

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Color(0xFF57BEE6),
              );
            }
            else if (snapshot.hasData) {
              return const HomeBase();
            }
            else {
              return const LoginView();
            }

          },
        ),

        routes: {
          '/home' : (context) => const HomeBase(),
          '/evacuationfinder': (context) => const EvacautionFinderView(),
          '/profile' : (context) => const ProfileView(),
          '/emergency': (context) => const EmergencyView(),
          '/naturalinfo': (context) => const NaturalDisasterView(),
          '/manmadeinfo': (context) => const ManMadeDisasterView(),
          '/newsfeed': (context) => const NewsView(),
          '/emergencykit': (context) => const EmergencyKitView(),
          '/weatherupdate': (context) => const WeatherView(),
          '/report': (context) => const ReportDamageView(),
          '/login': (context) => const LoginView(),
          '/register': (context) => const RegistrationView(),
          '/editprofile': (context) => const EditProfileView()
        },
        theme: lightMode,
        darkTheme: darktMode,
      ),
    );
  }
}
