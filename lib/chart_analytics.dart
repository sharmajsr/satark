import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphPage extends StatefulWidget {
 // final Widget child;

  //HomePage({Key key, this.child}) : super(key: key);

  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Task, String>> _seriesPieData1;
  List<charts.Series<Task, String>> _seriesPieData2;
  List<charts.Series<Task, String>> _seriesPieData3;

  String _btn2SelectedVal;
  static const menuItems = <String>[
    'KD Road',
    'Vijaynagar',
    'Bogadi'
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
  )
      .toList();
  var piedata;
  var piedata3;
  var piedata1;
  var piedata2;

  _generateData() {
    piedata = [
      new Task('Road Accidents', 20.8, Colors.blueAccent),
      new Task('Fire Accidents', 13.3, Color(0xffF7464A)),
      new Task('Other Accidents', 16.8, Colors.greenAccent),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.task}',
      ),
    );
    piedata1 = [
      new Task('Road Accidents', 35.8, Colors.blueAccent),
      new Task('Fire Accidents', 8.3, Color(0xffF7464A)),
      new Task('Other Accidents', 10.8, Colors.greenAccent),
    ];

    _seriesPieData1.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata1,
        labelAccessorFn: (Task row, _) => '${row.task}',
      ),
    );
    piedata2 = [
      new Task('Road Accidents', 8.8, Colors.blueAccent),
      new Task('Fire Accidents', 36.3, Color(0xffF7464A)),
      new Task('Other Accidents', 15.8, Colors.greenAccent),
    ];

    _seriesPieData2.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata2,
        labelAccessorFn: (Task row, _) => '${row.task}',
      ),
    );
    piedata3 = [
      new Task('Road Accidents', 10.8, Colors.blueAccent),
      new Task('Fire Accidents', 8.3, Color(0xffF7464A)),
      new Task('Other Accidents', 25.8, Colors.greenAccent),
    ];

    _seriesPieData3.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata3,
        labelAccessorFn: (Task row, _) => '${row.task}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesPieData1 = List<charts.Series<Task, String>>();
    _seriesPieData2 = List<charts.Series<Task, String>>();
    _seriesPieData3 = List<charts.Series<Task, String>>();

    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Accidents : '),
                trailing: DropdownButton(
                  value: _btn2SelectedVal,
                  hint: Text('Choose'),
                  onChanged: ((String newValue) {
                    setState(() {
                      _btn2SelectedVal = newValue;
                      print(_btn2SelectedVal+'\n\n');
                    });
                  }),
                  items: _dropDownMenuItems,
                ),
              ),
              Text(
                'Accidents',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              _btn2SelectedVal == null
                  ? Expanded(
                      child: charts.PieChart(_seriesPieData,
                          animate: true,
                          animationDuration: Duration(seconds: 1),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification:
                                  charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                            //  desiredMaxRows: 2,
                              cellPadding:
                                  new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts
                                      .MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            )
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                    labelPosition:
                                        charts.ArcLabelPosition.inside)
                              ])),
                    )
                  :  _btn2SelectedVal == 'KD Road'
                  ? Expanded(
                      child: charts.PieChart(_seriesPieData1,
                          animate: true,
                          animationDuration: Duration(seconds: 1),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification:
                                  charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              //desiredMaxRows: 2,
                              cellPadding:
                                  new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts
                                      .MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            )
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                    labelPosition:
                                        charts.ArcLabelPosition.inside)
                              ])),
                    )
                  :  _btn2SelectedVal == 'Vijaynagar'
                  ? Expanded(
                child: charts.PieChart(_seriesPieData2,
                    animate: true,
                    animationDuration: Duration(seconds: 1),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                      //  desiredMaxRows: 2,
                        cellPadding:
                        new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts
                                .MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 11),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition:
                              charts.ArcLabelPosition.inside)
                        ])),
              )
                  : Expanded(
                child: charts.PieChart(_seriesPieData3,
                    animate: true,
                    animationDuration: Duration(seconds: 1),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                       // desiredMaxRows: 2,
                        cellPadding:
                        new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts
                                .MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 11),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition:
                              charts.ArcLabelPosition.inside)
                        ])),
              )
              ,
            ],
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
