import 'package:disaster_main/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final datab = FirebaseDatabase.instance;
  bool _saving = false;
  Map data;
  bool validateName = false;
  bool validateEmail = false;
  bool validatePincode = false;
  bool validatePassword = false;
  bool validateUSN = false;
  bool validateBlock = false;
  bool validateRoom = false;
  bool validateMobile = false;
  bool pa = true, pb = false, pc = false;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController usnController = TextEditingController();

  TextEditingController blockController = TextEditingController();

  TextEditingController roomController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> signUp() async {
      try {
        AuthResult result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        FirebaseUser user = result.user;
        data = {
          "name": "${nameController.text}",
          "password": "${passwordController.text}",
          "email": "${emailController.text}",
          "uid": "${user.uid}",
          "role": "local",
          "pincode": "${pincodeController.text}"
//
        };
        Firestore.instance
            .collection("users")
            .document((emailController.text))
            .setData({
          "name": "${nameController.text}",
          "password": "${passwordController.text}",
          "email": "${emailController.text}",
          "pincode":"${pincodeController.text}",
          "role":"user"
        });
//        datab
//            .reference()
//            .child('users/' + nameController.text)
//            .set(data)
//            .catchError((e) {
//          print(e);
//        });

        print(user);

        user.sendEmailVerification();
        // _saving = false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } catch (e) {
        _saving = false;
        setState(() {});
        print(e.message);
        Toast.show(e.message, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: new Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
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
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("SignUp",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(45),
                        fontFamily: "Poppins-Bold",
                        letterSpacing: .6)),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Text("Name",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      value.isEmpty
                          ? validateName = true
                          : validateName = false;
                    });
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                      errorText: validateName ? "Name can\'t be empty" : null,
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(35),
                ),
                Text("Email",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  onChanged: (value) {
                    setState(() {
                      value.isEmpty
                          ? validateEmail = true
                          : validateEmail = false;
                    });
                  },
                  decoration: InputDecoration(
                      errorText: validateEmail ? "Email can\'t be empty" : null,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(35),
                ),
                Text("PIN Code",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: pincodeController,
                  onChanged: (value) {
                    setState(() {
                      value.isEmpty
                          ? validatePincode = true
                          : validatePincode = false;
                    });
                  },
                  decoration: InputDecoration(
                      errorText:
                          validatePincode ? "PIN Code can\'t be empty" : null,
                      hintText: "Pin Code",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(35),
                ),
                Text("Password",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      value.isEmpty
                          ? validatePassword = true
                          : validatePassword = false;
                    });
                  },
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      errorText:
                          validatePassword ? "Password can\'t be empty" : null,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(35),
                ),
                InkWell(
                  child: Center(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(250),
                      height: ScreenUtil.getInstance().setHeight(60),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
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
                              nameController.text.isEmpty
                                  ? validateName = true
                                  : validateName = false;
                              pincodeController.text.isEmpty
                                  ? validatePincode = true
                                  : validatePincode = false;
                            });

                            data = {
                              "name": "${nameController.text}",
//                                   "password": "${passwordController.text}",
                              "email": "${emailController.text}"
                            };
                            if (!(validateName &&
                                validatePassword &&
                                validateEmail &&
                                validatePincode
                            )) {
                              _saving = true;
                              signUp();
                            }
                          },
                          child: Center(
                            child: Text("SignUp",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
