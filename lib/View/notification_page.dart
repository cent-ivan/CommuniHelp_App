import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 25, 
        channelKey: 'sample_channel',
        title: 'Hello World',
        body: 'Simple Button'
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Page")
      ),

      body: Center(
      child: ElevatedButton(
          onPressed: triggerNotification,
          child: const Text("Trigger Notification"),
        )
      ),

    );
  }
}