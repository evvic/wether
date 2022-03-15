import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wether/widgets/weather_loaded/loaded_pressure.dart';
import 'package:wether/widgets/weather_loaded/loaded_wind.dart';

class LoadedWindPresRow extends StatelessWidget {
  double windSpeed;
  int windDir;
  int pressure;

  LoadedWindPresRow(
      {Key? key,
      required this.windSpeed,
      required this.windDir,
      required this.pressure})
      : super(key: key);

  static const ztyle = TextStyle(fontSize: 18);
  static const subZtyle = TextStyle(fontSize: 16, color: Colors.black45);

  @override
  Widget build(BuildContext context) {
    return
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: [
              LoadedPressure(pressure: pressure),
              LoadedWind(windSpeed: windSpeed, windDir: windDir),
            ],
        ));
  }
}
