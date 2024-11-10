import 'package:communihelp_app/View/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';



class NotificationController {
  Logger logger = Logger();

  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize notifications
  Future initNotification(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('communihelp');

    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    
    // Initialize notifications with a callback when notification is clicked
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notifResponse) async {
        // Navigate to the HomeBase screen when a notification is tapped
        if (notifResponse.payload != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeBase()),
          );
        }
      },
    );
  }

  // Notification details setup
  Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'announceId',
        'announceChannel',
        importance: Importance.max,
        icon: 'communihelp', // Ensure this icon is available in your drawable folder
      ),
    );
  }

  // Show a notification
  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload, // Optional: You can pass additional data if needed
    );
  }
}



// class NotificationController {
//   Logger logger = Logger();

//   final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndriod = AndroidInitializationSettings('communihelp');

//     var initializationSettings = InitializationSettings(android: initializationSettingsAndriod);
//     await notificationsPlugin.initialize(initializationSettings, 
//       onDidReceiveNotificationResponse: (NotificationResponse notifResponse) async {}
//     );
//   }

//    notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails('announceId', 'announceChannel', importance: Importance.max, icon: 'communihelp')
//     );
//    }

//   Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload
//   }) async {
//     return notificationsPlugin.show(
//       id, 
//       title, 
//       body, 
//       await notificationDetails()
//     );
//   }
// }