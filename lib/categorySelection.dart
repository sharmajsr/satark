import 'package:disaster_main/Disasters/map.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySelection extends StatefulWidget {
  @override
  _CategorySelectionState createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  final textStyle = TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Report an Accident',
          style: GoogleFonts.lato(fontSize: 30),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width / 3,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage('0')));
              },
              child: Card(
                  elevation: 12,
                  // color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.white,
                          child: Image.asset('assets/fire.png'),
                          // height: 100,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                            'Fire',
                            style: textStyle,
                          ))),
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width / 3,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage('1')));
              },
              child: Card(
                  elevation: 12,
                  // color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.white,
                          child: Image.asset('assets/accident.png'),
                          // height: 100,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                            'Road Accidents',
                            style: textStyle,
                          ))),
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width / 3,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage('3')));
              },
              child: Card(
                  elevation: 12,
                  // color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                          // color: Colors.amber,
                          child: Image.asset('assets/alert.png'),
                          // height: 100,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                            'ETC',
                            style: textStyle,
                          ))),
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
