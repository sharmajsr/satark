import 'dart:async';

import 'package:disaster_main/Authority/authority.dart';
import 'package:disaster_main/CountDown.dart';
import 'package:disaster_main/Disasters/MarkerMap.dart';
import 'package:disaster_main/Disasters/fire.dart';
import 'package:disaster_main/Disasters/map.dart';
import 'package:disaster_main/dashboard.dart';
import 'package:disaster_main/loginpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
String mytoken;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      home:  Login(),
    );
  }

}
//
//class HomePage extends StatefulWidget {
//
//
//  @override
//  State<HomePage> createState() => HomePageState();
//}
//
//class HomePageState extends State<HomePage> {
//  String longitude = '78.9629';
//  String latitude = '20.5937';
//  Completer<GoogleMapController> _controller=Completer();
//  MapType type;
//  static final CameraPosition _kGooglePlex = CameraPosition(
//    target: LatLng(37.42796133580664, -122.085749655962),
//    zoom: 14.4746,
//  );
//  Set<Marker> markers;
//
//  @override
//  void initState() {
//
//    // TODO: implement initState
//    super.initState();
//        type = MapType.normal;
//    markers = Set.from([]);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: AppBar(title:Text('GMap')),
//      body: Stack(
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(15.0),
//            child: GoogleMap(
//            //  myLocationButtonEnabled: true,
//              myLocationEnabled: true,
//           //   compassEnabled: true,
//              markers: markers,
//              mapType: type,
//              onTap: (position){
//                Marker mk1 = Marker(
//                  markerId: MarkerId('1'),
//                  position: position,
//                );
//                setState(() {
//                  markers.add(mk1);
//                });
//              },
//              initialCameraPosition: _kGooglePlex,
//              onMapCreated: (GoogleMapController controller) {
//                _controller.complete(controller);
//              },
//            ),
//          ),
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: Row(
//              children: <Widget>[
//                FloatingActionButton(
//                  onPressed: () {
//                    setState(() {
//                      type = type == MapType.hybrid ? MapType.normal : MapType.hybrid;
//                    });
//                  },
//                  child: Icon(Icons.map),
//                ),
//                FloatingActionButton(
//                  child: Icon(Icons.zoom_in),
//                  onPressed: () async{
//                    (await _controller.future).animateCamera(CameraUpdate.zoomIn());
//                  },
//                ),
//                FloatingActionButton(
//                  child: Icon(Icons.zoom_out),
//                  onPressed: () async {
//                    (await _controller.future).animateCamera(CameraUpdate.zoomOut());
//                  },
//                ),
//                FloatingActionButton.extended(
//                  icon: Icon(Icons.location_on),
//                  label: Text("My position"),
//                  onPressed: (){
//                    if(markers.length < 1)
//                      print("no marker added");
//                    print(markers.first.position);
//                  },
//                )
//              ],
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
