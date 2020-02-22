import 'package:disaster_main/messaging/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();


    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

      },
      onResume: (Map<String, dynamic> message) async {
        print("\n\nonResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) => ListView(
    children: messages.map(buildMessage).toList(),
  );

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );

//  void handleRouting(dynamic notification) {
//    switch (notification['title']) {
//      case 'news':
//        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => NewsList()));
//        break;
//      case 'events':
//        Navigator.push(context,
//            MaterialPageRoute(builder: (BuildContext context) => Events()));
//        break;
//      case 'jobs':
//        Navigator.push(context,
//            MaterialPageRoute(builder: (BuildContext context) => JobList()));
//        break;
//    }
//  }

  void sendTokenToServer(String fcmToken) {
    print('Token: $fcmToken');
  }
}
