import 'package:communihelp_app/CommuniHelp_Responder/View/Home_View/dashboard_components/manage_announcement.dart';
import 'package:communihelp_app/Databases/HiveServices/hive_db_weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:communihelp_app/CommuniHelp_Responder/View/Login_Responder/login_responder_view.dart';
import 'package:communihelp_app/CommuniHelp_Responder/View/Registration_Responder/registration_responder_view.dart';
import 'package:communihelp_app/CommuniHelp_Responder/View/Resport_Page/see_report_view.dart';
import 'package:communihelp_app/CommuniHelp_Responder/View/responder_base.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Model/Emergency_contact_model/emergency_contacts_model.dart';
import 'package:communihelp_app/Model/Emergency_kit_model/emergency_kit_model.dart';
import 'package:communihelp_app/CommuniHelp_Responder/View/Home_View/dashboard_components/announcement_make.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Profile_Page/change_email.dart';
import 'package:communihelp_app/View/Bottom_App_Bar_Pages/Profile_Page/change_password.dart';
import 'package:communihelp_app/View/Infographics/Man_Made_Disaster/Manmade_Info_Components/View_Page/manmade_info_page_view.dart';
import 'package:communihelp_app/View/Infographics/Natural_Disaster/Natural_Info_Components/View_Page/info_page_view.dart';
import 'package:communihelp_app/View/base_controller.dart';
import 'package:communihelp_app/View/settings_view.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/community_view_model.dart';
import 'package:communihelp_app/ViewModel/Home_View_Models/report_view_model.dart';
import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/manmade_dis_view_model.dart';
import 'package:communihelp_app/ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';
import 'package:communihelp_app/ViewModel/News_View_Model/news_view_model.dart';
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
import 'package:communihelp_app/auth_director.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'Databases/FirebaseServices/FirestoreServices/get_announcement.dart';
import 'ViewModel/Connection_Controller/dependency_injection.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  await dotenv.load(fileName: "lib/.env"); //initialize env
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Set preferred orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);



  //Hive local db
  await Hive.initFlutter();
  Hive.registerAdapter(EmergencyKitModelAdapter());
  Hive.registerAdapter(EmergencyContactsModelAdapter());

  await Hive.openBox<List>('emergencykit');
  await Hive.openBox<List>('emergencycontact');
  await Hive.openBox<Map<String, dynamic>>('weatherbox');

  await Hive.openBox<bool>('director');

  await initializeDateFormatting('en_PH', null); // Initialize for Philippines locale
  
  runApp(
    MultiProvider(
      providers: [
        //View Model for Pages
        ChangeNotifierProvider(create: ((context) => BaseController())),
        ChangeNotifierProvider(create: ((context) => EmergencyViewModel())),
        ChangeNotifierProvider(create: ((context) => AnnouncementViewModel())),
        ChangeNotifierProvider(create: ((context) => ProfileViewModel())),
        ChangeNotifierProvider(create: ((context) => EmergencyKitViewModel())),
        ChangeNotifierProvider(create: ((context) => NaturalDisasterViewModel())),
        ChangeNotifierProvider(create: ((context) => ManMadeDisasterViewModel())),
        ChangeNotifierProvider(create: ((context) => CommunityViewModel())),
        ChangeNotifierProvider(create: ((context) => ReportViewModel())),
        ChangeNotifierProvider(create: ((context) => NewsViewModel())),
        ChangeNotifierProvider(create: ((context) => HiveDbWeather())),

        //View Model for Firestore
        ChangeNotifierProvider(create: ((context) => RegistrationViewModel())),
        ChangeNotifierProvider(create: ((context) => GetUserData())),
        ChangeNotifierProvider(create: ((context) => GetAnnouncement())),

        ChangeNotifierProvider(create: ((context) => Director())),
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
    final director =  Provider.of<Director>(context);
    return  ScreenUtilInit(
      
      builder: (context, child) => GetMaterialApp(

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            director.loadDirection();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Color(0xFF57BEE6),
              );
            }
            else if (snapshot.hasData && !director.isResponder) {
              return const HomeBase();
            }
            else if (snapshot.hasData && director.isResponder) {
              //if logged in as responder
              return const HomeBaseResponder();
            }
            else if (director.isResponder) {
              //if goes to responder log in
              return const LoginResponderView();
            }
            else {
              return const LoginView();
            }

          },
        ),

        navigatorKey: navigatorKey,
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
          '/editprofile': (context) => const EditProfileView(),
          '/changeemail': (context) => const ChangeEmail(),
          '/changepass': (context) => const ChangePassword(),
          '/settings': (context) => const SettingsView(), 
          

          //Responder routes
          '/responderlogin': (context) => const LoginResponderView(),
          '/responderregister' : (context) => const RegistrationResponderView(),
          '/responderhome' : (context) => const HomeBaseResponder(),
          '/postannouncement': (context) => const AnnouncementMake(),
          '/manageannouncement': (context) => const ManageAnnouncement(),
          '/viewreport': (context) => const SeeReportView(),

          //Infograhics routes
          '/viewinfopage': (context) => const InfoPageView(),
          '/viewmanmadeinfopage': (context) => const ManmadeInfoPageView()
        },
        theme: lightMode,
        darkTheme: darktMode,
      ),
    );
  }
}



