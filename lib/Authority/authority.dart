import 'package:disaster_main/Authority/send_Notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Authority extends StatefulWidget {
  @override
  _AuthorityState createState() => _AuthorityState();
}

class _AuthorityState extends State<Authority> {
  DatabaseReference databaseReference;
  Map<dynamic, dynamic> data;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();

    //  complaint = Complaints("", "", "", "");
    databaseReference = database.reference();
    // databaseReference.onChildAdded.listen(onDataAdded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authority'),
      ),
      body: FirebaseAnimatedList(
          defaultChild: shimmers(),
          //Center(child: CircularProgressIndicator()),
          query: databaseReference.child('complaints/'),
          itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation,
              int index) {
            data = snapshot.value;
            print('$data');

            return eventCard(data);
          }),
    );
  }

  Widget shimmers() {
    return ListView(
      children: <Widget>[
        shimmerCard(),
        shimmerCard(),
        shimmerCard(),
        shimmerCard(),
        shimmerCard(),
        shimmerCard()
      ],
    );
  }

  Widget shimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget eventCard(Map data) {
    String severity;
    String str = '';
    severity = double.parse(data["sever"]) > 70
        ? "High Severity"
        : double.parse(data["sever"]) > 30 ? "Medium Severity" : "Low Severity";

    str = str + data["areaType"][0] == 'false' ? '' : 'School Area';

    str =
        str + data["areaType"][1] == 'false' ? '' : 'Electrical Infrastructure';
    str = str + data["areaType"][2] == 'false' ? '' : 'Public Marketplace';
    str = str + data["areaType"][3] == 'false' ? '' : 'Factory';
    str = str + data["areaType"][4] == 'false' ? '' : 'Others';
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ComplaintDetails(
                      data['name'],
                      severity,
                      str,
                      data['people'],data['alertIssued'],data['id'],data['areaType'],data['sever']
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Severity : $severity "),
              Text("AreaType : "),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  data["areaType"][0] == 'false'
                      ? Container()
                      : Text('School Area'),
                  data["areaType"][1] == 'false'
                      ? Container()
                      : Text('Electrical Infrastructure'),
                  data["areaType"][2] == 'false'
                      ? Container()
                      : Text('Public Marketplace'),
                  data["areaType"][3] == 'false'
                      ? Container()
                      : Text('Factory'),
                  data["areaType"][4] == 'false' ? Container() : Text('Others'),
                ],
              ),
              Text("People : ${data['people']} "),
            ],
          ),
        ),
      ),
    );
  }
}
