import 'package:disaster_main/loginpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:disaster_main/MessagePage.dart';
String mytoken;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//
//  @override
//  void initState() {
//
//  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}


