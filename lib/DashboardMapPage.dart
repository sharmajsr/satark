//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//
//class DashboardMap extends StatefulWidget {
//  @override
//  _DashboardMapState createState() => _DashboardMapState();
//}
//
//class _DashboardMapState extends State<DashboardMap> {
//  String longitude = '78.9629';
//  String latitude = '20.5937';
//
//  Set<Marker> markers;
//  Completer<GoogleMapController> _controller = Completer();
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    markers = Set.from([]);
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: MediaQuery.of(context).size.height,
//      width: MediaQuery.of(context).size.width,
//      child: GoogleMap(
//        myLocationButtonEnabled: true,
//        compassEnabled: true,
//        myLocationEnabled: true,
//        markers: markers,
//        onTap: (position) {
//          Marker mk1 = Marker(
//            markerId: MarkerId('1'),
//            position: position,
//          );
////          setState(() {
////
////            if (markers.isEmpty) showButton = !showButton;
////            buttonColor = Colors.red;
////            textColor = Colors.white;
////            markers.add(mk1);
////          });
//        },
//        mapType: MapType.normal,
//        onMapCreated: (GoogleMapController controller) {
//          _controller.complete(controller);
//        },
//        initialCameraPosition: CameraPosition(
//          target: LatLng(double.parse(latitude), double.parse(longitude)),
//          zoom: 5,
//        ),
//        //  markers: {myMarker},
//      ),
//    );
//  }
//}
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardMapPage extends StatefulWidget {
//  double  latitude ;
//  String title;
//  double  longitude ;
//  DashboardMapPage(this.latitude,this.longitude,this.title);

  @override
  _DashboardMapPageState createState() => _DashboardMapPageState();
}

class _DashboardMapPageState extends State<DashboardMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  DatabaseReference databaseReference;
  Map data;
  double loc;
  double lat;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  List<Marker> allMarkers = [];
  List<Circle> allCircles = [];

  var _firebaseRef = FirebaseDatabase().reference().child('location/');
  @override
  void initState() {
    super.initState();

    databaseReference = database.reference();

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Event>(
      stream:   _firebaseRef.onValue,
      //databaseReference.child('location/').onValue,
      builder: (BuildContext context, AsyncSnapshot<Event> event) {
        if (event.hasData){
          //print(' Data \n '+event.data.snapshot.value.toString()+'\n\n');
          data=event.data.snapshot.value;
          data.forEach((key, value) {
            print('Key Values' + key + ' ' + ' ${value['loc']}');
            allCircles.add(Circle(
              fillColor: Colors.red.withOpacity(0.2),
              strokeWidth: 0,
              circleId: CircleId('${value['id']}'),
              center: LatLng(value['lat'], value['loc']),
              radius: 1000,
            ));

            allMarkers.add(Marker(
                markerId: MarkerId('${value['id']}'),
                draggable: true,
                infoWindow: InfoWindow(title: 'Mysore'),
                onTap: () {
                  print('Marker Tapped');
                },
                position: LatLng(value['lat'], value['loc'])));

            print('Data : ${value}\n\nLength : ${allMarkers.length}');
          });
        //  setState(() {});
          return Stack(children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: GoogleMap(
                myLocationEnabled: true,
                onCameraMove: (CameraPosition cameraPosition) {
                  print(cameraPosition.zoom);
                },
                zoomGesturesEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition:
                CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 5.0),
                markers: Set.from(allMarkers),
                circles: Set.from(allCircles),
              ),
            ),
          ]);
        }
        else
          return Center(child: CircularProgressIndicator());
      }
    );
  }
}
