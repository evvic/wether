import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadedPressure extends StatefulWidget {
  final int pressure;

  LoadedPressure({Key? key, required this.pressure}) : super(key: key);

  @override
  _LoadedPressure createState() => _LoadedPressure(key, pressure);
}

class _LoadedPressure extends State<LoadedPressure> {
  late Color col;
  late String humidityLevel;

  int pressure;

  _LoadedPressure(Key? key, this.pressure);

  @override
  void initState() {
    super.initState();

    setState(() {
      //col = getColor();
      //humidityLevel = getHumidityLevel();
    });
  }
  //{Key? key, required this.percentage, required this.feelsLike})
  //  : super(key: key);

/*
  getHumidityLevel() {
    if (percentage < 25) {
      return "Very low";
    } else if (percentage >= 25 && percentage < 30) {
      return "Low";
    } else if (percentage >= 30 && percentage < 60) {
      return "Good";
    } else if (percentage >= 60 && percentage < 70) {
      return "High";
    } else if (percentage >= 70) {
      return "Very high";
    } else {
      return "Undetectable";
    }
  }*/

  //static final hLevelStyle = TextStyle(fontSize: 18, color: col);
  static const subZtyle = TextStyle(fontSize: 18, color: Colors.black54);
  static const feelLikeZtyle = TextStyle(
      fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold);

  // in the future maybe add some color to this that represetns how hot and/or cool the high and low is for today
  // represent through a background gradient of red to blue, i.e. where a hotter day would be more red
  @override
  Widget build(BuildContext context) {
    return Expanded(
        //child: AspectRatio(
      //aspectRatio: 1 / 1.15,
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
              // PRESSURE HEADING
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: FittedBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.wifi_tethering_rounded,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      "PRESSURE",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    )
                  ],
                )),
              ),
              // BAROMETER UI
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Expanded(
                    //fit: FlexFit.tight,
                    //flex: 1,
                    child: CustomPaint(
                      //size: Size.infinite,
                      //size: Size(110, 110),
                      foregroundPainter: PressurePainter(pressure),
                      child: Padding(
                          //fit: FlexFit.loose,
                          padding: const EdgeInsets.all(33.0),
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  pressure.toString(),
                                  style: feelLikeZtyle,
                                ),
                                Text("hPa"),
                              ],
                            ),
                          )),
                    ),
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
              ),
            ],
          ),
        ),
      //),
    ));
  }
}

class PressurePainter extends CustomPainter {
  int pressure;

  PressurePainter(this.pressure);

  /* CONSTANTS */
  double strokeWidth = 8;
  double baseAngle = (5 * pi / 4) - (pi / 2);
  double endAngle = 2 * pi * .75;

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
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
        endAngle, false, line);
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
