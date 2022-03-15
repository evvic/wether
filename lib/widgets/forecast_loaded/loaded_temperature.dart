import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wether/model/forecast_day.dart';
import 'package:wether/services/forecast_services.dart';

class LoadedTemperature extends StatelessWidget {
  int tempDay;
  int tempMin;
  int tempMax;
  int index;

  int weekMin;
  int weekMax;

  final double MAX_BAR_WIDTH = 100.0;
  final double BAR_HEIGHT = 8;

  LoadedTemperature(
      {Key? key,
      required this.tempDay,
      required this.tempMin,
      required this.tempMax,
      required this.weekMin,
      required this.weekMax,
      required this.index})
      : super(key: key);

  static const dayNameStyle = TextStyle(
      fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold);
  static const defaultDayNameStyle =
      TextStyle(fontSize: 16, color: Colors.black87);

  Color calcColor(int temp) {
    /* CONSTANTS */
    const int TRUE_MIN = -35;
    Color MIN_COLOR = Colors.blue.shade700;
    const int COLD = 5;
    Color COLD_COLOR = Colors.blue.shade200;
    const int WARM = 15;
    Color WARM_COLOR = Colors.yellow.shade500;
    const int TRUE_MAX = 45;
    Color MAX_COLOR = Colors.red.shade700;
    /**************/

    // locally calculate percent for gradient
    // between 0 and 1
    double percent(int high, int low) {
      return ((temp - low) / 1.0) / (high - low);
    }

    if (temp <= TRUE_MIN)
      return MIN_COLOR;
    else if (temp <= COLD)
      return Color.lerp(MIN_COLOR, COLD_COLOR, percent(TRUE_MIN, COLD))!;
    else if (temp <= WARM)
      return Color.lerp(COLD_COLOR, WARM_COLOR, percent(COLD, WARM))!;
    else if (temp <= TRUE_MAX)
      return Color.lerp(WARM_COLOR, MAX_COLOR, percent(WARM, TRUE_MAX))!;
    else
      return MAX_COLOR;
  }

  List<Color> calcGradient() {
    const int STEP = 1;

    List<Color> ret = [calcColor(tempMax)];

    for (int i = 0; i < ((tempMax - tempMin) % STEP); i++) {
      ret.add(calcColor(tempMax - STEP));
    }

    ret.add(calcColor(tempMin));

    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                //child: Text(tempDay.toString() + 'C', style: TextStyle(fontWeight: FontWeight.bold),)
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: "Daytime "),
                        TextSpan(
                            text: tempDay.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "°C"),
                      ]),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(tempMin.toString() + '°',
                      style: TextStyle(fontSize: 16, color: Colors.black45))
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MAX_BAR_WIDTH,
                        height: BAR_HEIGHT,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black12, Colors.black26],
                              begin: Alignment(-0.7, 12),
                              end: Alignment(1, -2),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        //child: Text("hello")
                      ),
                      // add transform and calculate movement of bar
                      Transform.translate(
                        offset: Offset(
                            // the bar begins leftmost, move it right to be relative to the max
                            ((tempMin - weekMin) *
                                (MAX_BAR_WIDTH / (weekMax - weekMin))),
                            0 //do not move the y-axis of the bar
                            ),
                        child: Container(
                          width: (tempMax - tempMin) /
                              (weekMax - weekMin) *
                              MAX_BAR_WIDTH,
                          height: BAR_HEIGHT,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: calcGradient(),
                                begin: Alignment(-0.7, 12),
                                end: Alignment(1, -2),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          //child: Text("hello")
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(tempMax.toString() + '°',
                      style: TextStyle(fontSize: 16, color: Colors.black54))
                  ),
                ],
              ),
            )

            //Text("what")
            //https://stackoverflow.com/questions/60019684/use-gradient-with-paint-object-in-flutter-canvas
            // ^ gradient painter line
          ],
        ));
  }
}
