import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashed_circle/dashed_circle.dart';

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

  /* WIDGET CONSTANTS */
  double wCont = 60; //inner tranparent container
  double hCont = 60; //inner tranparent container

  var compassPrimary = Colors.deepOrange.shade100; //lightBlueAccent;
  var compassSecondary = Colors.deepOrange; //lightBlue;

  late double xIcon;
  late double yIcon;

  _LoadedWind(Key? key, this.windSpeed, this.windDir);

  @override
  void initState() {
    super.initState();

    setState(() {
      xIcon = (wCont / 2 + 10) * cos(windDir / 180);
      yIcon = (hCont / 2 + 10) * sin(windDir / 180);
    });
  }

  toKmh(double ws) {
    int ret = 4;
    return ret;
  }

  //static final hLevelStyle = TextStyle(fontSize: 18, color: col);
  static const subZtyle = TextStyle(fontSize: 14, color: Colors.black54);
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
                  children: [
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
              // COMPASS UI
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Stack(alignment: Alignment.center, children: [
                  DashedCircle(
                      dashes: 100,
                      strokeWidth: 20,
                      color: Colors.black,
                      child: AspectRatio(
                          aspectRatio: 1,
                          //child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // NORTH
                            children: [
                              CardinalCharacter(char: 'N'),
                              // WEST, MIDDLE, EAST
                              Center(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CardinalCharacter(char: 'W'),
                                  // keep container here to maintain structure of
                                  // cardinal characters
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle),
                                    //constraints: BoxConstraints.expand(),
                                    //color: Colors.blue,
                                    width: wCont,
                                    height: hCont,
                                  ),
                                  CardinalCharacter(char: 'E'),
                                ],
                              )),
                              CardinalCharacter(char: 'S'),
                            ],
                          )
                        )
                      ),
                  // Circle
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: compassPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: compassSecondary, width: 5),
                    ),
                    width: 80,
                    height: 80,
                  ),
                  // inner wind speed text
                  Column(
                    children: [
                      Text(toKmh(windSpeed).toString(), style: feelLikeZtyle,),
                      Text("km/h", style: subZtyle,)],
                  ),

                  // Translate arrow icon to point and be on the right side
                  Transform.translate(
                    offset: Offset(
                        (wCont / 1.2) * cos(pi * (windDir - 90) / 180.0),
                        (hCont / 1.2) * sin(pi * (windDir - 90) / 180.0)),
                    child: Transform.rotate(
                      angle: pi * (windDir / 180.0),
                      child: Icon(Icons.details_rounded,
                          size: 30, color: compassSecondary),
                    ),
                  )
                  //)
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class CardinalCharacter extends StatelessWidget {
  final String char;

  CardinalCharacter({required this.char});

  static const cStyle = TextStyle(
      fontSize: 12, color: Colors.black45, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0), child: Text(char, style: cStyle));
  }
}
