import 'package:disaster_main/Disasters/fire.dart';
import 'package:disaster_main/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

//
//class CountDown extends StatefulWidget {
//  @override
//  CountDownState createState() => CountDownState();
//}
//
//class CountDownState extends State<CountDown> with TickerProviderStateMixin {
//  AnimationController controller;
//
//  // bool isPlaying = false;
//
//  String get timerString {
//    Duration duration = controller.duration * controller.value;
//    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    controller = AnimationController(
//      vsync: this,
//      duration: Duration(seconds: 10),
//    );
//
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ThemeData themeData = Theme.of(context);
//    return Scaffold(
//      body: Padding(
//        padding: EdgeInsets.all(8.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Expanded(
//              child: Align(
//                alignment: FractionalOffset.center,
//                child: AspectRatio(
//                  aspectRatio: 1.0,
//                  child: Stack(
//                    children: <Widget>[
//                      Positioned.fill(
//                        child: AnimatedBuilder(
//                          animation: controller,
//                          builder: (BuildContext context, Widget child) {
//                            return CustomPaint(
//                                painter: TimerPainter(
//                                  animation: controller,
//                                  backgroundColor: Colors.white,
//                                  color: themeData.indicatorColor,
//                                ));
//                          },
//                        ),
//                      ),
//                      Align(
//                        alignment: FractionalOffset.center,
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Text(
//                              "Count Down",
//                              style: themeData.textTheme.subhead,
//                            ),
//                            AnimatedBuilder(
//                                animation: controller,
//                                builder: (BuildContext context, Widget child) {
//                                  return Text(
//                                    timerString,
//                                    style: themeData.textTheme.display4,
//                                  );
//                                }),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              margin: EdgeInsets.all(8.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  FloatingActionButton(
//                    child: AnimatedBuilder(
//                      animation: controller,
//                      builder: (BuildContext context, Widget child) {
//                        return Icon(controller.isAnimating
//                            ? Icons.pause
//                            : Icons.play_arrow);
//
//                        // Icon(isPlaying
//                        // ? Icons.pause
//                        // : Icons.play_arrow);
//                      },
//                    ),
//                    onPressed: () {
//                      // setState(() => isPlaying = !isPlaying);
//
//                      if (controller.isAnimating) {
//                        controller.stop(canceled: true);
//                      } else {
//                        controller.reverse(
//                            from: controller.value == 0.0
//                                ? 1.0
//                                : controller.value);
//                      }
//                    },
//                  )
//                ],
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class TimerPainter extends CustomPainter {
//  TimerPainter({
//    this.animation,
//    this.backgroundColor,
//    this.color,
//  }) : super(repaint: animation);
//
//  final Animation<double> animation;
//  final Color backgroundColor, color;
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    Paint paint = Paint()
//      ..color = backgroundColor
//      ..strokeWidth = 5.0
//      ..strokeCap = StrokeCap.round
//      ..style = PaintingStyle.stroke;
//
//    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
//    paint.color = color;
//    double progress = (1.0 - animation.value) * 2 * math.pi;
//    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
//  }
//
//  @override
//  bool shouldRepaint(TimerPainter old) {
//    return animation.value != old.animation.value ||
//        color != old.color ||
//        backgroundColor != old.backgroundColor;
//  }
//}
class Confirmed extends StatefulWidget {
  String id;

  Confirmed(this.id);

  @override
  _ConfirmedState createState() => _ConfirmedState();
}

class _ConfirmedState extends State<Confirmed> {
  final DBref = FirebaseDatabase.instance.reference();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  var _firebaseRef = FirebaseDatabase().reference();
  bool ans = false;
  Map data;
  String title = 'Results';
final textStyle=TextStyle(fontSize: 15,fontWeight: FontWeight.w400);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Event>(
        stream: _firebaseRef.child('complaints/' + widget.id).onValue,
        //databaseReference.child('location/').onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> event) {
          if (event.hasData) {
            data = event.data.snapshot.value;
            if (data != null) {
              print('Data : $data\n\n');
            }
            if (data['alertIssued'] != 'false')
              return Scaffold(
                  appBar: AppBar(
                    title: Text('$title'),
                    backgroundColor: Color(0xff028090),
                  ),
                  body: Center(
                      child: Container(
                          child: Text('Your request has been Accepted',style:textStyle ,))));
            else
              return Scaffold(
                  appBar: AppBar(
                    title: Text('$title'),
                    backgroundColor: Color(0xff028090),
                  ),
                  body: Center(child: Text('Your request is in under Review',style:textStyle)));
          } else
            return Scaffold(
                appBar: AppBar(
                  title: Text('$title'),
                  backgroundColor: Color(0xff028090),
                ),
                body: Center(child: Text('Your request is in under Review',style:textStyle)));
        });
  }
}
