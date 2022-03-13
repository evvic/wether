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
  static const subZtyle = TextStyle(fontSize: 20, color: Colors.black87);
  static const feelLikeZtyle = TextStyle(fontSize: 16, color: Colors.black87);

  // in the future maybe add some color to this that represetns how hot and/or cool the high and low is for today
  // represent through a background gradient of red to blue, i.e. where a hotter day would be more red
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AspectRatio(
      aspectRatio: 1 / 1,
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
                padding:
                    const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.wb_incandescent_rounded,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      "PRESSURE",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    )
                  ],
                ),
              ),
              CustomPaint(
                //size: Size.infinite,
                size: Size(100, 100),
                foregroundPainter: PressurePainter(pressure),
              ),
              Text("in and max")
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

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arc1 = Path();
    arc1.moveTo(0, size.height * 0.6);
    arc1.arcToPoint(Offset(size.width, size.height * 0.6),
        radius: Radius.circular(4));

    canvas.drawPath(arc1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
