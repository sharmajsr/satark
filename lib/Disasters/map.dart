import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';
import 'package:flutter/services.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  String longitude = '78.9629';
  String latitude = '20.5937';
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getMyLocationData();
  }

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
      longitude = currentLocation.longitude.toString();
      latitude = currentLocation.latitude.toString();
      setState(() {
        //print('Calling setsate');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text('Location example'),
//        ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
           compassEnabled: true,
           myLocationEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(double.parse(latitude), double.parse(longitude)),
            zoom: 11,
          ),
          //markers: {myMarker},
        ),
      ),
//        Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text(
//                'Your current location:',
//              ),
//              Text(
//                'longitude: $longitude\nlatitude: $latitude',
//                style: Theme.of(context).textTheme.display1,
//              ),
//            ],
//          ),
//        ),
    );
  }
}
