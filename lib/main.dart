import 'package:disaster_main/dashboard.dart';
import 'package:disaster_main/loginpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
String mytoken;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      home:  Login(),
    );
  }
//  String getdeviceToken() {
//    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//
////    if (Platform.isIOS) {
////      _firebaseMessaging.configure();
////      _firebaseMessaging.subscribeToTopic('all');
////      _firebaseMessaging.requestNotificationPermissions(
////        IosNotificationSettings(sound: true, badge: true, alert: true),
////      );
////    }
//
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("onMessage: $message");
////      _showItemDialog(message);
//      },
////    onBackgroundMessage: myBackgroundMessageHandler,
////    onLaunch: (Map<String, dynamic> message) async {
////      print("onLaunch: $message");
//////      _navigateToItemDetail(message);
////    },
//      onResume: (Map<String, dynamic> message) async {
//        print("onResume: $message");
////      _navigateToItemDetail(message);
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print('on launch: $message');
//      },
//    );
//
////    _firebaseMessaging.onIosSettingsRegistered
////        .listen((IosNotificationSettings settings) {
////      print('Hello ' + settings.toString());
////    });
//
//    _firebaseMessaging.getToken().then((token) {
//      mytoken = token;
//
//      print('\n\nToken:$mytoken\n\n');
//    });
//    return mytoken;
//  }
}
