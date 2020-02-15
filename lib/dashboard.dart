import 'package:disaster_main/Disasters/fire.dart';
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
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(child: myCard(context,'Fire'),onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fire()),
                );
              },),
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
                  ),
              ),
              Expanded(flex: 2, child: Center(child: Text(type))),
            ],
          )),
    ),
  );
}
