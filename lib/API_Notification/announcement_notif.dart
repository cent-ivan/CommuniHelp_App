import 'package:communihelp_app/View/base_controller.dart';
import 'package:communihelp_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class AnnouncementNotif {
  Logger logger = Logger();
  //cinstance friebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  final baseController = BaseController();

  //gets the
  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  //handles received messages
  void handleMessage(RemoteMessage? message) {
    // ignore: unnecessary_null_comparison
    if (message == null) return;

    //user taps on notification
    navigatorKey.currentState?.pushNamed('/home', arguments: message);
  }

  //initialize foreground and background settings
  Future initPushNotification() async {
    //app is terminated and opened
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    //attach event listners
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}