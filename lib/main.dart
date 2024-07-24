import 'package:communihelp_app/ViewModels/emergency_view_model.dart';
import 'package:communihelp_app/ViewModels/theme.dart';
import 'package:communihelp_app/Views/Utility_Pages/Emergency_Kit/emergency_kit_view.dart';
import 'package:communihelp_app/Views/Utility_Pages/Evacuation_Finder/evacaution_finder_view.dart';
import 'package:communihelp_app/Views/Infographics/manmade_disaster_view.dart';
import 'package:communihelp_app/Views/Infographics/natural_disaster_view.dart';
import 'package:communihelp_app/Views/Utility_Pages/News_Feed/news_view.dart';
import 'package:communihelp_app/Views/Bottom_App_Bar_Pages/Profile_Page/profile_view.dart';
import 'package:communihelp_app/Views/Bottom_App_Bar_Pages/Emergency_Page/emergency_view.dart';
import 'package:communihelp_app/Views/Utility_Pages/Weather_Page/weather_view.dart';
import 'package:communihelp_app/Views/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Set preferred orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => EmergencyViewModel())),
      ],
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  ScreenUtilInit(
      //designSize: Size(sizeWidth, sizeHeight),
      builder: (context, child) => MaterialApp(

        //TODO:add classes to Led Light and Report Damage (No designs yet)
        home: const HomeBase(),
        routes: {
          '/home' : (context) => const HomeBase(),
          '/profile' : (context) => const ProfileView(),
          '/emergency': (context) => const EmergencyView(),
          '/naturalinfo': (context) => const NaturalDisasterView(),
          '/manmadeinfo': (context) => const ManMadeDisasterView(),
          '/newsfeed': (context) => const NewsView(),
          '/emergencykit': (context) => const EmergencyKitView(),
          '/weatherupdate': (context) => const WeatherView(),
          '/evacuationfinder': (context) => const EvacautionFinderView()
        },
        theme: lightMode,
        darkTheme: darktMode,
      ),
    );
  }
}
