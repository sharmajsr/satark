import 'package:disaster_main/Disasters/map.dart';
import 'package:flutter/material.dart';


class CategorySelection extends StatefulWidget {
  @override
  _CategorySelectionState createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width / 3,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
              child: Card(
                  color: Colors.blue,
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
                      Expanded(flex: 2, child: Center(child: Text('Fire'))),
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
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
              child: Card(

                  color: Colors.blue,
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
                          child: Center(child: Text('Road Accidents'))),
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
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
              child: Card(
                  color: Colors.blue,
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
                      Expanded(flex: 2, child: Center(child: Text('ETC'))),
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
