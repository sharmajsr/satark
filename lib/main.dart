import 'package:disaster_main/Authority/authority.dart';
import 'package:disaster_main/dashboard.dart';
import 'package:disaster_main/loginpage.dart';
import 'package:disaster_main/model/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:disaster_main/MessagePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

String mytoken;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _login, _role;

  void initState() {
    super.initState();
    // CommonData.clearLoggedInUserData();
    shared();
  }

  shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _login = (prefs.getString(Constants.isLoggedIn));
      _role = (prefs.getString(Constants.loggedInUserRole));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _login == 'true'
          ? ( _role == "user" ? Dashboard() : Authority())
          : Login(),
    );
  }
}
