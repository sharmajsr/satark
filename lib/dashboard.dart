import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashbaord'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              myCard(context,'Fire'),
              myCard(context,'Land Accident'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              myCard(context,'Animal'),
              myCard(context,'ETC'),
            ],
          ),
        ],
      ),
    );
  }
}

Widget myCard(BuildContext context,String type) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: MediaQuery.of(context).size.width / 3,
      width: MediaQuery.of(context).size.width / 3,
      child: Card(
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.amber,
                  // height: 100,
                  width: double.infinity,
                  child: Image.network(
                      'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'),
                ),
              ),
              Expanded(flex: 2, child: Center(child: Text(type))),
            ],
          )),
    ),
  );
}
