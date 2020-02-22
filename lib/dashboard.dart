
import 'package:disaster_main/CountDown.dart';
import 'package:disaster_main/Disasters/fire.dart';
import 'package:disaster_main/Disasters/map.dart';
import 'package:disaster_main/MessagePage.dart';
import 'package:disaster_main/messaging/message.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void sendTokenToServer(String fcmToken) {
    print('Token: $fcmToken');
  }

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

//  void fcmSubscribe() {
//    firebaseMessaging.subscribeToTopic('local');
//    print('Subscribed To commond');
//  }

  String deviceToken;
  void handleRouting(dynamic notification) {
    switch (notification['title']) {
      case 'fire':
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => FirstPage()));
        break;
      case 'events':
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Confirmed('33')));
        break;
//      case 'jobs':
//        Navigator.push(context,
//            MaterialPageRoute(builder: (BuildContext context) => JobList()));
//        break;
    }
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        final notification = message['data'];
        handleRouting(notification);
        print("\n\nonResume: $message");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    firebaseMessaging.subscribeToTopic('auth').then((val) {
      print('Subscribed To auth in dashboard');
      firebaseMessaging.getToken().then((token) {
        deviceToken = token;
        print('\n\nToken  ' + token);
      });
      sendTokenToServer(deviceToken);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => MapPage()));
                },
                child: Card(
                    color: Colors.blue,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: Colors.white,
                            child: Image.asset('assets/fire.png'),
                            // height: 100,
                            width: double.infinity,
                          ),
                        ),
                        Expanded(flex: 2, child: Center(child: Text('Fire'))),
                      ],
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: Card(
                  color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.white,
                          child: Image.asset('assets/accident.png'),
                          // height: 100,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Center(child: Text('Road Accidents'))),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: Card(
                  color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                          // color: Colors.amber,
                          child: Image.asset('assets/alert.png'),
                          // height: 100,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(flex: 2, child: Center(child: Text('ETC'))),
                    ],
                  )),
            ),
          )
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              InkWell(
//                child: myCard(context, 'Fire'),
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Fire()),
//                  );
//                },
//              ),
//              InkWell(
//                child: myCard(context, ' Accident'),
//                onTap: () {
////                  Navigator.push(
////                    context,
////                    MaterialPageRoute(builder: (context) => MyApe()),
////                  );
//                },
//              ),
//            ],
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              InkWell(
//                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => MyMap()),
//                    );
//                  },
//                  child: myCard(context, 'Animal','animal.p')),
//              InkWell(
//                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => Authority()),
//                    );
//                  },
//                  child: myCard(context, 'ETC')),
//            ],
//          )
        ],
      ),
    );
  }
}

Widget myCard(BuildContext context, String type, String image) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: MediaQuery.of(context).size.width / 3,
      width: MediaQuery.of(context).size.width / 3,
      child: Card(
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Container(
                  // color: Colors.amber,
                  child: Image.asset('fire.png'),
                  // height: 100,
                  width: double.infinity,
                ),
              ),
              Expanded(flex: 2, child: Center(child: Text(type))),
            ],
          )),
    ),
  );
}
