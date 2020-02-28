import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class DashboardMap extends StatefulWidget {
  @override
  _DashboardMapState createState() => _DashboardMapState();
}

class _DashboardMapState extends State<DashboardMap> {
  String longitude = '78.9629';
  String latitude = '20.5937';

  Set<Marker> markers;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers = Set.from([]);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        myLocationButtonEnabled: true,
        compassEnabled: true,
        myLocationEnabled: true,
        markers: markers,
        onTap: (position) {
          Marker mk1 = Marker(
            markerId: MarkerId('1'),
            position: position,
          );
//          setState(() {
//
//            if (markers.isEmpty) showButton = !showButton;
//            buttonColor = Colors.red;
//            textColor = Colors.white;
//            markers.add(mk1);
//          });
        },
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(latitude), double.parse(longitude)),
          zoom: 5,
        ),
        //  markers: {myMarker},
      ),
    );
  }
}
