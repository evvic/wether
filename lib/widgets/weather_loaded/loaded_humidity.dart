import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadedHumidity extends StatefulWidget {
  final int percentage;
  final int feelsLike;

  LoadedHumidity({Key? key, required this.percentage, required this.feelsLike})
      : super(key: key);

  @override
  _LoadedHumidity createState() => _LoadedHumidity(key, percentage, feelsLike);
}

class _LoadedHumidity extends State<LoadedHumidity> {
  late Color col;
  late String humidityLevel;

  int percentage;
  int feelsLike;

  _LoadedHumidity(Key? key, this.percentage, this.feelsLike);

  @override
  void initState() {
    super.initState();

    setState(() {
      col = getColor();
      humidityLevel = getHumidityLevel();
    });
  }

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
  }

  getColor() {
    if (percentage < 25) {
      return Colors.red;
    } else if (percentage >= 25 && percentage < 30) {
      return Colors.yellow;
    } else if (percentage >= 30 && percentage < 60) {
      return Colors.green;
    } else if (percentage >= 60 && percentage < 70) {
      return Colors.yellow;
    } else if (percentage >= 70) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  //static final hLevelStyle = TextStyle(fontSize: 18, color: col);
  static const subZtyle = TextStyle(fontSize: 20, color: Colors.black87);
  static const feelLikeZtyle = TextStyle(fontSize: 16, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Container(
          width: double.infinity,
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
                    //Humidity icon + title
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.waves_rounded,
                            color: Colors.blueGrey,
                          ),
                          Text(
                            "HUMIDITY",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                    // percentage and relation
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("$percentage%", style: subZtyle),
                            const Icon(Icons.circle_rounded, size: 10),
                            Text(humidityLevel,
                                style: TextStyle(color: col, fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 15.0),
                        child: RichText(
                          text: TextSpan(style: feelLikeZtyle, children: <
                              TextSpan>[
                            TextSpan(text: "Humidity is making it feel like "),
                            TextSpan(
                                text: "$feelsLike°C",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ".")
                          ]),
                        ))
                  ],
                ),
              ))),
    );
  }
}
