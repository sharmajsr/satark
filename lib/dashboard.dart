import 'package:disaster_main/Authority/authority.dart';
import 'package:disaster_main/Disasters/MarkerMap.dart';
import 'package:disaster_main/Disasters/fire.dart';
import 'package:disaster_main/Disasters/map.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseMessaging.getToken().then((token) {
      deviceToken = token;
      print('\n\nToken  ' + token);
    });
    firebaseMessaging.subscribeToTopic('auth').then((val) {
      print('Subscribed To commond');
    });
    sendTokenToServer(deviceToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: myCard(context, 'Fire'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fire()),
                  );
                },
              ),
              InkWell(child: myCard(context, 'Land Accident'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAppe()),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyMap()),
                    );
                  },
                  child: myCard(context, 'Animal')),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Authority()),
                    );
                  },
                  child: myCard(context, 'ETC')),
            ],
          )
        ],
      ),
    );
  }
}

Widget myCard(BuildContext context, String type) {
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
                  color: Colors.amber,
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
