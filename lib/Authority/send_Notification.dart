import 'dart:async';

import 'package:disaster_main/messaging/messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
      this.longitude);

  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState();
}

final FirebaseDatabase database = FirebaseDatabase.instance;

class _ComplaintDetailsState extends State<ComplaintDetails> {
//  String name;
//  String severity;
//  String AreaType;
//  String people;
  Completer<GoogleMapController> _controller = Completer();

//  Set<Marker> markers;
  List<Marker> allMarkers = [];

  void initState() {
    super.initState();
    // addMarkerr();

    allMarkers.add(Marker(

        markerId: MarkerId('myMarker'),
        draggable: true,
        infoWindow: InfoWindow(
          title: 'Adress of location'
        ),
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(widget.latitude, widget.longitude)));
  }

  static const textStyle = TextStyle(
    fontSize: 16,
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
                        'Name : ${widget.name}',
                        style: textStyle,
                      ),
                      Text(
                        'Severity : ${widget.severity}',
                        style: textStyle,
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
                      Text(
                        'AreaType : ${widget.AreaType}',
                        style: textStyle,
                      ),
                      Text(
                        'Latitude : ${widget.latitude}',
                        style: textStyle,
                      ),
                      Text(
                        'Longitude : ${widget.longitude}',
                        style: textStyle,
                      ),

                      Row(
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
                      ),


                      widget.alertIssued == 'false'
                          ? RaisedButton(
                        color: Colors.red,
                              child: Text('Issue an Alert',style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                Map data = {
                                  "name": "${widget.name}",
                                  "sever": "${widget.sever}",
                                  "people": "${widget.people}",
                                  "areaType": widget.areaType,
                                  "alertIssued": "true",
                                  "id": "${widget.id}",
                                  "latitude": "${widget.latitude}",
                                  "longitude": "${widget.longitude}"
                                };
                                database
                                    .reference()
                                    .child("complaints/" + widget.id)
                                    .set(data);
                                widget.alertIssued = 'true';
                                Messaging.sendToTopic(
                                        title: 'fire',
                                        body: 'Verified Fire Alert',
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
//                      Container(
//                        height: 400,
//                        child: GoogleMap(
//                          myLocationButtonEnabled: true,
//                          compassEnabled: true,
//                          myLocationEnabled: true,
//                          markers: markers,
//                          mapType: MapType.normal,
//                          onMapCreated: (GoogleMapController controller) {
//                            _controller.complete(controller);
//                          },
//
//                          initialCameraPosition: CameraPosition(
//                            target: LatLng(double.parse(widget.latitude),
//                                double.parse(widget.longitude)),
//                            zoom: 11,
//                          ),
//                          //  markers: {myMarker},
//                        ),
//                      ),
//                      Stack(
//                          children: [Container(
//                            height: MediaQuery.of(context).size.height,
//                            width: MediaQuery.of(context).size.width,
//                            child: GoogleMap(
//
//                              initialCameraPosition:
//                              CameraPosition(target: LatLng(widget.latitude, widget.longitude), zoom: 12.0),
//                              markers: Set.from(allMarkers),
//                              onMapCreated: mapCreated,
//                            ),
//                          ),
//                          ]
//                      ),
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
                  onCameraMove:(CameraPosition cameraPosition){
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
