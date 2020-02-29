import 'dart:async';
import 'dart:convert';
import 'package:disaster_main/Disasters/RoadAccident.dart';
import 'package:disaster_main/Disasters/fire.dart';
import 'package:disaster_main/model/Address.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  String type;
  MapPage(this.type);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> markers;
  Map data;
  Color buttonColor = Colors.white;
  Color textColor = Colors.black;
  final snackBar = SnackBar(content: Text('Add '));
  String longitude = '78.9629';
  String latitude = '20.5937';
  double lat;
  double long;
  bool showButton = false;

  Completer<GoogleMapController> _controller = Completer();

  Future<http.Response> fetchAddress() async{
    final response = await  http.get('https://us1.locationiq.com/v1/reverse.php?key=42257cbcdd9559&lat=$lat&lon=$long&format=json');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      //return Address.fromJson(jsonDecode(response.body));
      data = jsonDecode(response.body);
      print(response.body);
      return response;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers = Set.from([]);
   fetchAddress();
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
      appBar: AppBar(
        title: Text('Location example'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
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
                setState(() {

                  if (markers.isEmpty) showButton = !showButton;
                  buttonColor = Colors.red;
                  textColor = Colors.white;
                  markers.add(mk1);
                });
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
          ),

          showButton == false
              ? Container()
              : Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonTheme(
                  //minWidth: 200.0,
                  //height: 30.0,

                  child: RaisedButton(
                    textColor: Colors.white,

                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text('  Clear Location  ',style: TextStyle(fontSize: 16),),
                    onPressed: () {

                      markers.clear();
                      buttonColor = Colors.white;
                      textColor = Colors.black;
                      showButton = !showButton;
                      setState(() {});
                    },
                  ),
                ),
                RaisedButton(
                  textColor: textColor,
                  color: buttonColor,
                  onPressed: () async {
                    print('My Markers');
                    print(markers);
                    print('\n\n');
                    if (markers.length < 1) {
                      print("no marker added");
                      //Scaffold.of(context).showSnackBar(snackBar);
                    } else
//                    print(markers.first.position);
//                    print(markers.first.position.latitude );
                    print('\n\n');
                    lat= markers.first.position.latitude;
                    long=markers.first.position.longitude;
                    await fetchAddress();
                    if(widget.type=='0')
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Fire(
                              markers.first.position.latitude,
                              markers.first.position.longitude,data['address'])),
                    );
                    else
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoadAccident(
                                markers.first.position.latitude,
                                markers.first.position.longitude,data['address'])),
                      );

                  },
                  child: Text('Select This Location',style: TextStyle(fontSize: 16),),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
