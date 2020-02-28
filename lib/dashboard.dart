import 'package:disaster_main/CountDown.dart';
import 'package:disaster_main/DashboardMapPage.dart';
import 'package:disaster_main/Disasters/fire.dart';
import 'package:disaster_main/Disasters/map.dart';
import 'package:disaster_main/MessagePage.dart';
import 'package:disaster_main/categorySelection.dart';
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

  int _selectedIndex = 0;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

//  void fcmSubscribe() {
//    firebaseMessaging.subscribeToTopic('local');
//    print('Subscribed To commond');
//  }

  String deviceToken;

  void handleRouting(dynamic notification) {
    print(
        'Openin Lat Long ${notification['latitude']}  ${notification['longitude']}\n\n');

    switch (notification['title']) {
      case 'fire':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => FirstPage(
                    double.parse(notification['latitude']),
                    double.parse(notification['longitude']),
                  notification['location']
                )));
        break;
      case 'events':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Confirmed('33')));
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

    firebaseMessaging.subscribeToTopic('auth').then((val) {
      print('Subscribed To auth in dashboard');
      firebaseMessaging.getToken().then((token) {
        deviceToken = token;
        print('\n\nToken  ' + token);
      });
      sendTokenToServer(deviceToken);
    });
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
//        final notification = message['data'];
//        handleRouting(notification);

        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        final notification = message['data'];
        handleRouting(notification);
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

//    firebaseMessaging.subscribeToTopic('auth').then((val) {
//      print('Subscribed To auth in dashboard');
//      firebaseMessaging.getToken().then((token) {
//        deviceToken = token;
//        print('\n\nToken  ' + token);
//      });
//      sendTokenToServer(deviceToken);
//    });
  }

  List<Widget> _widgetOptions = <Widget>[
    CategorySelection(),
    DashboardMap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
//        selectedItemColor: Colors.black,
//        unselectedItemColor: Colors.white,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Category Selection'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Accident Prone'),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
//
//Widget myCard(BuildContext context, String type, String image) {
//  return Padding(
//    padding: const EdgeInsets.all(15.0),
//    child: Container(
//      height: MediaQuery.of(context).size.width / 3,
//      width: MediaQuery.of(context).size.width / 3,
//      child: Card(
//          color: Colors.blue,
//          child: Column(
//            children: <Widget>[
//              Expanded(
//                flex: 7,
//                child: Container(
//                  // color: Colors.amber,
//                  child: Image.asset('fire.png'),
//                  // height: 100,
//                  width: double.infinity,
//                ),
//              ),
//              Expanded(flex: 2, child: Center(child: Text(type))),
//            ],
//          )),
//    ),
//  );
//}
