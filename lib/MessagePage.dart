import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirstPage extends StatefulWidget {
  double  latitude ;

  double  longitude ;
  FirstPage(this.latitude,this.longitude);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  List <Circle> allCircles =[];
  void initState() {
    super.initState();
    // addMarkerr();
  allCircles.add(Circle(
   fillColor: Colors.blue.withOpacity(0.2),
strokeWidth: 0,
      circleId: CircleId('1'),
      center: LatLng(widget.latitude, widget.longitude),
      radius: 2000,
    ));
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Page'),),
      body: Stack(children: [
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
                zoom: 13.0),
           markers: Set.from(allMarkers),
            circles: Set.from(allCircles),
            onMapCreated: mapCreated,
          ),
        ),
      ]),
    );
  }
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
