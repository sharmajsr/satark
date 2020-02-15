import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_main/dashboard.dart';
import 'package:disaster_main/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  bool validateEmail = false;
  bool validatePassword = false;
  String name, usn, role, mobile, block, room;
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget radioButton(bool isSelected) => Container(
    width: 16.0,
    height: 16.0,
    padding: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2.0, color: Colors.black)),
    child: isSelected
        ? Container(
      width: double.infinity,
      height: double.infinity,
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: Colors.black),
    )
        : Container(),
  );

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[

              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 40.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(250),
                      ),
                      formCard(),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              width: ScreenUtil.getInstance().setWidth(330),
                              height: ScreenUtil.getInstance().setHeight(100),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF17ead9),
                                    Color(0xFF6078ea)
                                  ]),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      emailController.text.isEmpty
                                          ? validateEmail = true
                                          : validateEmail = false;
                                      passwordController.text.isEmpty
                                          ? validatePassword = true
                                          : validatePassword = false;
                                    });
                                    if (!validateEmail && !validatePassword) {
                                      //isLoading==false? CircularProgressIndicator(),signIn():
                                      _saving=true;
                                      signIn();
                                    }
                                  },
                                  child: Center(
                                    child: Text("SIGNIN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(40),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(40),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "New User? ",
                            style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: 15.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text("SignUp",
                                style: TextStyle(
                                    color: Color(0xFF5d74e3),
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 15.0)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    //final forState = formKey.currentState;

    try {
      //Center(child: CircularProgressIndicator(backgroundColor: Colors.black,strokeWidth: 50,));
      final FirebaseUser user = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text))
          .user;
      print(user.uid);
//      var d = await Firestore.instance
//          .collection('users')
//          .document(emailController.text)
//          .get()
//          .then((DocumentSnapshot) async {
//        name = DocumentSnapshot.data['name'];
//        usn = DocumentSnapshot.data['usn'];
//        role = DocumentSnapshot.data['role'];
//        block = DocumentSnapshot.data['block'];
//        room = DocumentSnapshot.data['room'];
//        mobile = DocumentSnapshot.data['mobile'];
//        print("name : $name");
//        final prefs = await SharedPreferences.getInstance();
//
//        prefs.setString(Constants.loggedInUserRole, role);
//        prefs.setString(Constants.loggedInUserBlock, block);
//        prefs.setString(Constants.loggedInUserRoom, room);
//        prefs.setString(Constants.loggedInUserMobile, mobile);
//        prefs.setString(Constants.loggedInUserName, name);
//        prefs.setString(Constants.isLoggedIn, 'true');
      //  print("Constants name : ${Constants.loggedInUserMobile}");
      //     print(DocumentSnapshot.data.toString());
      //});
      _saving=false;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>Dashboard(),));
    } catch (e) {
      print(e.message);
      _saving = false;
      setState(() {

      });
      Toast.show(e.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  formCard() {
    return Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(600),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Login",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Username",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            TextField(
              controller: emailController,
              onChanged: (value) {
                setState(() {
                  value.isEmpty ? validateEmail = true : validateEmail = false;
                });
              },
              decoration: InputDecoration(
                  errorText: validateEmail ? "Email can\'t be empty" : null,
                  hintText: "username",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Password",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    value.isEmpty
                        ? validatePassword = true
                        : validatePassword = false;
                  });
                },
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    errorText:
                    validatePassword ? "Password can\'t be empty" : null,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(40),
            ),
          ],
        ),
      ),
    );
  }
}
