import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Fire extends StatefulWidget {
  @override
  _FireState createState() => _FireState();
}

final FirebaseDatabase database = FirebaseDatabase.instance;

class _FireState extends State<Fire> {
  String url;
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

  //int height4= MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire '),
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
//                FlatButton(
//                  onPressed: () {
//                    getImageCamera();
//                  },
//                  child: sampleImage == null
//                      ?  Container(
//                    width: 60,
//                    height: 60,
//                    color: Colors.blue,
//                    child: Center(child: Icon(Icons.add)),
//                  )
//                      : uploadPicture()
//                ),
//                RaisedButton(
//                  onPressed: () {
//                    getImageCamera();
//                  },
//                  child: sampleImage == null
//                      ?  Container(
//                    width: 60,
//                    height: 60,
//                    color: Colors.blue,
//                    child: Center(child: Icon(Icons.add)),
//                  )
//                      : uploadPicture(),
//                ),
//                InkWell(
//                  onTap: getImageCamera,
//                  child: Container(
//                    width: 60,
//                    height: 60,
//                    color: Colors.blue,
//                    child: Center(child: Icon(Icons.add)),
//                  ),
//                ),RaisedButton(
//                  onPressed: () {
//                    getImageCamera();
//                  },
//                  child: sampleImage == null
//                      ?  Container(
//                    width: 60,
//                    height: 60,
//                    color: Colors.blue,
//                    child: Center(child: Icon(Icons.add)),
//                  )
//                      : uploadPicture()
//                ),
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FlatButton(
                color: Colors.grey,
                onPressed: () {
                  Map data = {
                    "name": "shubham",
                  };

                  database.reference().child("complaints/" + 'name/').set(data);
                },
                child: Text('Push Me'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImageCamera() async {
    var tempImage = await ImagePicker.pickImage(
      source: ImageSource.camera,
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
      source: ImageSource.camera,
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
      source: ImageSource.camera,
      imageQuality: 40,
    );
    setState(() {
//        if(sampleImage==null)
//           sampleImage= File("assets/image_02.png");
      sampleImage2 = tempImage;
      filename = sampleImage2.toString();
    });
  }

//  _showChoiceDialog() {
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//              title: Text('Choose'),
//              content: SingleChildScrollView(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: <Widget>[
//                    RaisedButton(
//                        elevation: 8.0,
//                        onPressed: () {
//                          getImageCamera();
//                          Navigator.of(context).pop();
//                        },
//                        child: Text('Camera')),
//                    RaisedButton(
//                        elevation: 8.0,
//                        onPressed: () {
//                          getImageGallery();
//                          Navigator.of(context).pop();
//                        },
//                        child: Text('Gallery')),
//                  ],
//                ),
//              ));
//        });
//  }
//  Future getImageGallery() async {
//    var tempImage = await ImagePicker.pickImage(
//      source: ImageSource.gallery,
//      imageQuality: 40,
//    );
//    setState(() {
////        if(sampleImage==null)
////           sampleImage= File("assets/image_02.png");
//      sampleImage = tempImage;
//      filename = sampleImage.toString();
//    });
//  }

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
}
