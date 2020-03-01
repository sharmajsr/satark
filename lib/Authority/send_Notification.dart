import 'dart:async';

import 'package:disaster_main/messaging/messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ComplaintDetails extends StatefulWidget {
  String name;
  String severity;
  String AreaType;
  String people;
  String alertIssued;
  String id;
  List areaType;
  String sever;
  double longitude;
  double latitude;
  Map address;
  String type;
  String timestamp;
  ComplaintDetails(
      this.name,
      this.severity,
      this.AreaType,
      this.people,
      this.alertIssued,
      this.id,
      this.areaType,
      this.sever,
      this.latitude,
      this.longitude,
      this.address,
      this.type,this.timestamp);

  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState();
}

final FirebaseDatabase database = FirebaseDatabase.instance;

class _ComplaintDetailsState extends State<ComplaintDetails> {
//  String name;
//  String severity;
//  String AreaType;
//  String people;
  String title;
  String body;
  Completer<GoogleMapController> _controller = Completer();

//  Set<Marker> markers;
  List<Marker> allMarkers = [];

  void initState() {
    super.initState();
    // addMarkerr();
    print('Adressss' + '${widget.address}' + '\n\n');
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        infoWindow: InfoWindow(title: 'Adress of location'),
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(widget.latitude, widget.longitude)));
  }

  static const textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,

  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff028090),
        title: Text('ComplaintDetail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
        child: ListView(
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 6.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                      Container(height: 400,
//                        width: 400,
//                        child: Image.network(
//                          widget.url,
//                        ),
//                      ),
                      Text(
                        'Name : ${widget.name.toUpperCase()}',
                        style: textStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:9.0),
                        child: Text(
                          'Severity : ${widget.severity}',
                          style: textStyle,
                        ),
                      ),
                      Text(
                        'People : ${widget.people}',
                        overflow: TextOverflow.ellipsis,
                        style: textStyle,
                      ),
//                      Text(
//                        'ID :  ${widget.id}',
//                        style: textStyle,
//
//                      ),
                      widget.type=='fire'? Text(
                        'AreaType : ${widget.AreaType}',
                        style: textStyle,
                      ):Container(),
//                      Text(
//                        'Latitude : ${widget.latitude}',
//                        style: textStyle,
//                      ),
//                      Text(
//                        'Longitude : ${widget.longitude}',
//                        style: textStyle,
//                      ),

                      widget.type=='fire'?Row(
                        children: <Widget>[
                          Container(
                            height: 90,
                            width: 90.0,
                            child: Image.asset('assets/download.jpg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 90,
                              width: 90.0,
                              child: Image.asset('assets/download1.jpg'),
                            ),
                          ),
                        ],
                      ):Container(),

                      widget.alertIssued == 'false'
                          ? RaisedButton(
                              color: Colors.red,
                              child: Text(
                                'Issue an Alert',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
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
                                  "name": "${widget.name}",
                                  "sever": "${widget.sever}",
                                  "people": "${widget.people}",
                                  "areaType": widget.areaType,
                                  "alertIssued": "true",
                                  "id": "${widget.id}",
                                  "latitude": "${widget.latitude}",
                                  "type": "${widget.type}",
                                  "timestamp":"${widget.timestamp}",
                                  "longitude": "${widget.longitude}",
                                  "address": widget.address
                                };
                                database
                                    .reference()
                                    .child("location/")
                                    .push()
                                    .set({
                                  'id': '$location',
                                  'loc': '${widget.longitude}',
                                  'lat': '${widget.latitude}'
                                });
                                database
                                    .reference()
                                    .child("complaints/" + widget.id)
                                    .set(data);
                                widget.alertIssued = 'true';
                                if(widget.type=='fire')
                                {
                                  title='Fire Alert 🔥';
                                  body='Fire Alert at $location';
                                }
                                else
                                  {
                                    title='Road Accident 🚗';
                                    body='Road Accident Alert at $location';
                                  }
                                Messaging.sendToTopic(
                                        //title: 'fire',
                                        title: '$title',
                                        body: '$body',
                                        latitude: "${widget.latitude}",
                                        longitude: "${widget.longitude}",
                                        location: "${location}",
                                        topic: 'auth')
                                    .then((val) {
                                  print('Subscribed to local');
                                });
                                setState(() {});
                              },
                            )
                          : RaisedButton(
                              child: Text('Confirmed'),
                              onPressed: null,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  onCameraMove: (CameraPosition cameraPosition) {
                    print(cameraPosition.zoom);
                  },
                  zoomGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitude, widget.longitude),
                      zoom: 12.0),
                  markers: Set.from(allMarkers),
                  onMapCreated: mapCreated,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
