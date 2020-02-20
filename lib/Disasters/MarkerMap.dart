import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';


class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String longitude='nothing yet';
  String latitude='nothing yet';

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
      print("Latitude : ${currentLocation.latitude}\nLongitude : ${currentLocation.longitude}");

      setState(() {
        longitude = currentLocation.longitude.toString();
        latitude  = currentLocation.latitude.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Location example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your current location:',
              ),
              Text(
                'longitude: $longitude \n Latitude: $latitude',
                style: Theme.of(context).textTheme.display1,
              ),

            ],
          ),
        ),
      ),
    );
  }
}