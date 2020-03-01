import 'dart:async';
import 'dart:io';
import 'package:disaster_main/CountDown.dart';
import 'package:disaster_main/main.dart';
import 'package:flutter/services.dart';
import 'package:disaster_main/messaging/message.dart';
import 'package:disaster_main/messaging/messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:random_string/random_string.dart';

class Fire extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Map address;
  Fire(this.latitude, this.longitude,this.address);

  @override
  _FireState createState() => _FireState();
}

final FirebaseDatabase database = FirebaseDatabase.instance;

class _FireState extends State<Fire> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String url;
  String url1;
  String url2;
  String people;
  double val = 0.0;
  bool lowPeople = false;
  bool mediumPeople = false;
  bool largePeople = false;
  bool unknownPeople = true;
  bool areaType1 = false;
  bool areaType2 = false;
  bool areaType3 = false;
  bool areaType4 = false;
  bool areaType5 = false;
  File sampleImage, sampleImage2, sampleImage1;
  String filename;
  String random;
  String subscriber = "local";
  String deviceToken;
  final List<Message> messages = [];
  String longitude = 'nothing yet';
  String latitude = 'nothing yet';
  int _currentIndex = 0;

  void getMyLocationData() async {
    var currentLocation = LocationData;

    var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var location = new Location();
      var currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // error = 'Permission denied';
      }
      currentLocation = null;
    }
    location.onLocationChanged().listen((LocationData currentLocation) {
      print(
          "Latitude : ${currentLocation.latitude}\nLongitude : ${currentLocation.longitude}");

      setState(() {
        longitude = currentLocation.longitude.toString();
        latitude = currentLocation.latitude.toString();
      });
    });
  }

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    this.getMyLocationData();
    print('Getiing address');
      print(widget.address);
      print('\n\n');
    _firebaseMessaging.getToken().then((token) {
      deviceToken = token;
      print('\n\nToken' + token);
    });
    firebaseMessaging.subscribeToTopic('all').then((val) {
      print('Subscribed To commond');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
//    _firebaseMessaging.requestNotificationPermissions(
//        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );

  //int height4= MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Fire '),
        backgroundColor: Color(0xff028090),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '1. Severity of Fire',
              style: GoogleFonts.lato(fontSize: 20),
            ),
            Slider(
              activeColor: val > 65
                  ? Colors.red
                  : val > 20 ? Colors.orange : Colors.yellow,
              value: val,
              onChanged: (newVal) {
                setState(() {
                  val = newVal;
                });
              },
              min: 0,
              max: 100,
            ),
            Text(
              '2. No of People Involved',
              style: GoogleFonts.lato(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('1-2'),
                      Checkbox(
                        value: lowPeople,
                        onChanged: (val) {
                          lowPeople = true;
                          mediumPeople = false;
                          largePeople = false;
                          unknownPeople = false;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('3-10'),
                      Checkbox(
                        value: mediumPeople,
                        onChanged: (val) {
                          lowPeople = false;
                          mediumPeople = true;
                          largePeople = false;
                          unknownPeople = false;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('10+'),
                      Checkbox(
                        value: largePeople,
                        onChanged: (val) {
                          lowPeople = false;
                          mediumPeople = false;
                          largePeople = true;
                          unknownPeople = false;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Unknown'),
                      Checkbox(
                        value: unknownPeople,
                        onChanged: (val) {
                          lowPeople = false;
                          mediumPeople = false;
                          largePeople = false;
                          unknownPeople = true;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              '3. Area Type ',
              style: GoogleFonts.lato(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: areaType1,
                        onChanged: (val) {
                          areaType1 = !areaType1;
//                          areaType2 = false;
//                          areaType3 = false;
//                          areaType4 = false;
//                          areaType5 = false;
                          setState(() {});
                        },
                      ),
                      Text('School Area'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: areaType2,
                        onChanged: (val) {
                          //areaType1 = false;
                          areaType2 = !areaType2;
                          //  areaType3 = false;
                          //areaType4 = false;
                          //areaType5 = false;

                          setState(() {});
                        },
                      ),
                      Text('Electrical Infrastructure'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: areaType3,
                        onChanged: (val) {
//                          areaType1 = false;
//                          areaType2 = false;
                          areaType3 = !areaType3;
//                          areaType4 = false;
//                          areaType5 = false;
                          setState(() {});
                        },
                      ),
                      Text('Public / Marketplace'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: areaType4,
                        onChanged: (val) {
//                          areaType1 = false;
//                          areaType2 = false;
//                          areaType3 = false;
                          areaType4 = !areaType4;
//                          areaType5 = false;
                          setState(() {});
                        },
                      ),
                      Text('Factory'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: areaType5,
                        onChanged: (val) {
//                          areaType1 = false;
//                          areaType2 = false;
//                          areaType3 = false;
//                          areaType4 = false;
                          areaType5 = !areaType5;
                          setState(() {});
                        },
                      ),
                      Text('Others'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '4. Upload Image ( *Optional )',
                style: GoogleFonts.lato(fontSize: 20),
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.,
              //mainAxisAlignment: MainAxisAlignment.satr,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      getImageCamera();

                    },
                    child: sampleImage == null
                        ? Container(
                            width: 60,
                            height: 60,
                            color: Colors.blue,
                            child: Center(child: Icon(Icons.add)),
                          )
                        : uploadPicture()),
                FlatButton(
                    onPressed: () {
                      getImageCameraO();
                    },
                    child: sampleImage1 == null
                        ? Container(
                            width: 60,
                            height: 60,
                            color: Colors.blue,
                            child: Center(child: Icon(Icons.add)),
                          )
                        : uploadPicture1()),
                FlatButton(
                    onPressed: () {
                      getImageCameraT();
                    },
                    child: sampleImage2 == null
                        ? Container(
                            width: 60,
                            height: 60,
                            color: Colors.blue,
                            child: Center(child: Icon(Icons.add)),
                          )
                        : uploadPicture2()),
              ],
            ),
//

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FlatButton(
                color: Colors.grey,
                onPressed: () async {
                  print(sampleImage.toString());
//                  if (sampleImage != null) var sUrl = await uploadImage();

//                 if(sampleImage1!=null) var sUrl1 = await uploadImage1();
//                 if(sampleImage2!=null)  var sUrl2 = await uploadImage2();

                  if (lowPeople)
                    people = "low People";
                  else if (mediumPeople)
                    people = "medium People";
                  else if (largePeople)
                    people = "large People";
                  else
                    people = "unknown";
                  List l = [
                    '$areaType1',
                    '$areaType2',
                    '$areaType3',
                    '$areaType4',
                    '$areaType5'
                  ];
                  List imList;
//                 if(areaType1)  l.add('1');
//                 if(areaType2)  l.add('2');
//                 if(areaType3)  l.add('3');
//                 if(areaType4)  l.add('4');
//                 if(areaType5)  l.add('5');
//                 if(sUrl.isNotEmpty) imList.add(sUrl);
//                 if(sUrl1.isNotEmpty) imList.add(sUrl1);
//                 if(sUrl2.isNotEmpty) imList.add(sUrl2);
                  var id = randomAlphaNumeric(6);
                  String location = '';
                  if ('${widget.address}'
                      .contains('neighbourhood'))
                    location = widget.address['neighbourhood'];
                  else if ('${widget.address}'.contains('road'))
                    location = widget.address['road'];
                  else if ('${widget.address}'.contains('county'))
                    location = widget.address['county'];
                  else if ('${widget.address}'.contains('city'))
                    location = widget.address['city'];
                  else
                    location = widget.address['state'];
                  Map data = {
                    "name": "shubham",
                    "sever": "$val",
                    "people": "$people",
                    "areaType": l,
                    "id": "$id",
                    "alertIssued": "false",
                    "latitude": "${widget.latitude}",
                    "longitude": "${widget.longitude}",
                    "address":widget.address,
                    "timestamp": "${DateTime.now()}",
                    "type":"fire"
                    //   "images":imList
                  };

                  print("\n\n $data \n\n");
                  database
                      .reference()
                      .child("complaints/" + '$id')
                      .set(data)
                      .catchError((e) {
                    print('ERROR ho gya $e\n\n');
                  });

                  //Messaging.sendToAll(title: 'Fire', body: 'Unverified Fire Alert ');
                  Messaging.sendToTopic(
                          title: 'Fire News',
                          body: 'Unverified Fire Alert at $location',
                          topic: 'auth')
                      .then((val) {
                    print('Subscribed to $subscriber');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Confirmed(id)),
                      //Confirmed(id)),
                    );
                  });
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImageCamera() async {
    var tempImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    setState(() {
//        if(sampleImage==null)
//           sampleImage= File("assets/image_02.png");
      sampleImage = tempImage;
      filename = sampleImage.toString();
    });
  }

  Future getImageCameraO() async {
    var tempImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    setState(() {
//        if(sampleImage==null)
//           sampleImage= File("assets/image_02.png");
      sampleImage1 = tempImage;
      filename = sampleImage1.toString();
    });
  }

  Future getImageCameraT() async {
    var tempImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    setState(() {
//        if(sampleImage==null)
//           sampleImage= File("assets/image_02.png");
      sampleImage2 = tempImage;
      filename = sampleImage2.toString();
    });
  }

  Widget uploadPicture() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            Image.file(
              sampleImage,
              height: 60,
              width: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadPicture1() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            Image.file(
              sampleImage1,
              height: 60,
              width: 60,
            ),
//            RaisedButton(
//              elevation: 8.0,
//              child: Text('Select another'),
//              onPressed: getImageCamera,
//            ),
          ],
        ),
      ),
    );
  }

  Widget uploadPicture2() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            Image.file(
              sampleImage2,
              height: 60,
              width: 60,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> uploadImage() async {
    // print('\n\n$filename\n\n');
    random = randomAlphaNumeric(6);
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$random');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);
    var downUrl = await (await task.onComplete).ref.getDownloadURL();
    url = downUrl.toString();
    //print('Download Url $url');
    return url;
  }

  Future<String> uploadImage1() async {
    // print('\n\n$filename\n\n');
    random = randomAlphaNumeric(6);
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$random');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage1);
    var downUrl = await (await task.onComplete).ref.getDownloadURL();
    url1 = downUrl.toString();
    //print('Download Url $url');
    return url1;
  }

  Future<String> uploadImage2() async {
    // print('\n\n$filename\n\n');
    random = randomAlphaNumeric(6);
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$random');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage2);
    var downUrl = await (await task.onComplete).ref.getDownloadURL();
    url2 = downUrl.toString();
    //print('Download Url $url');
    return url2;
  }
}
