import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadedWind extends StatefulWidget {
  final double windSpeed;
  final int windDir;

  LoadedWind({Key? key, required this.windSpeed, required this.windDir})
      : super(key: key);

  @override
  _LoadedWind createState() => _LoadedWind(key, windSpeed, windDir);
}

class _LoadedWind extends State<LoadedWind> {
  late Color col;
  late String humidityLevel;

  double windSpeed;
  int windDir;

  _LoadedWind(Key? key, this.windSpeed, this.windDir);

  @override
  void initState() {
    super.initState();

    setState(() {
      //col = getColor();
      //humidityLevel = getHumidityLevel();
    });
  }

  //static final hLevelStyle = TextStyle(fontSize: 18, color: col);
  static const subZtyle = TextStyle(fontSize: 18, color: Colors.black54);
  static const feelLikeZtyle = TextStyle(
      fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AspectRatio(
      aspectRatio: 1 / 1.15,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // should stack right after another
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // WIND HEADING
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.air_rounded,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      "WIND",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Stack(
                    children: [
                      const Icon(Icons.location_searching_rounded,
                          color: Colors.blueGrey, size: 100),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.details,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "960",
                    style: subZtyle,
                  ),
                  Text(
                    "1060",
                    style: subZtyle,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class PressurePainter extends CustomPainter {
  int pressure;

  PressurePainter(this.pressure);

  /* CONSTANTS */
  double strokeWidth = 8;
  double baseAngle = 0;     //(5 * pi / 4) - (pi / 2);
  double endAngle = 2 * pi; //2 * pi * .75;

  @override
  void paint(Canvas canvas, Size size) {
    final compass = Paint()
      ..color = Colors.teal
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final complete = Paint()
      ..color = Colors.tealAccent
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    // check bounds of barometer
    pressure = max(pressure, 960);
    pressure = min(pressure, 1060);

    // using barameter min 960 and max 1060
    double arcAngle = 2 * pi * ((pressure - 960) / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), baseAngle,
        endAngle, false, compass);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), baseAngle,
        arcAngle, false, complete);

    //final arc1 = Path();
    //arc1.moveTo(0, size.height * 0.6);
    //arc1.arcToPoint(Offset(size.width, size.height * 0.6),
    //    radius: Radius.circular(4));

    //canvas.drawPath(arc1, paint);
  }

  //double sweepAngle() => 0.8 * 2 / 3 * math.pi;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
