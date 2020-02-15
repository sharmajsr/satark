import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ComplaintDetails extends StatefulWidget {
  String name;
  String severity;
  String AreaType;
  String people;
  String alertIssued;
  String id;
  List areaType;
  String sever;

  ComplaintDetails(this.name, this.severity, this.AreaType, this.people,
      this.alertIssued, this.id, this.areaType, this.sever);

  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState();
}

final FirebaseDatabase database = FirebaseDatabase.instance;

class _ComplaintDetailsState extends State<ComplaintDetails> {
//  String name;
//  String severity;
//  String AreaType;
//  String people;

  void initState() {
    //super.initState();
//    if (this.widget.status == "Done") {
//      val = true;
//      statusChange = dText;
//    } else {
//      val = false;
//      statusChange = pText;
//    }
  }

  static const textStyle = TextStyle(
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff028090),
        title: Text('ComplaintDetail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
        child: ListView(
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 6.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                      Container(height: 400,
//                        width: 400,
//                        child: Image.network(
//                          widget.url,
//                        ),
//                      ),
                      Text(
                        'Name : ${widget.name}',
                        style: textStyle,
                      ),
                      Text(
                        'Severity : ${widget.severity}',
                        style: textStyle,
                      ),
                      Text(
                        'People : ${widget.people}',
                        overflow: TextOverflow.ellipsis,
                        style: textStyle,
                      ),
//                      Text(
//                        'ID :  ${widget.id}',
//                        style: textStyle,
//
//                      ),
                      Text(
                        'AreaType : ${widget.AreaType}',
                        style: textStyle,
                      ),
//                      Text(
//                        'Room : ${widget.room}',
//                        style: textStyle,
//                      ),
//                      Text(
//                        'Time : ${widget.time}',
//                        style: textStyle,
//                      ),

                      widget.alertIssued == 'false'
                          ? RaisedButton(
                              child: Text('Issue an Alert'),
                              onPressed: () {
                                Map data = {
                                  "name": "${widget.name}",
                                  "sever": "${widget.sever}",
                                  "people": "${widget.people}",
                                  "areaType": widget.areaType,
                                  "alertIssued": "true",
                                  "id": "${widget.id}"
                                };
                                database
                                    .reference()
                                    .child("complaints/" + widget.id)
                                    .set(data);
                                widget.alertIssued = 'true';
                                setState(() {});
                              },
                            )
                          : RaisedButton(
                              child: Text('Confirm'),
                              onPressed: null,
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
