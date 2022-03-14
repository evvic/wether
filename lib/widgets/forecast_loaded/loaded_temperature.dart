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

  LoadedTemperature(
      {Key? key,
      required this.tempDay,
      required this.tempMin,
      required this.tempMax,
      required this.index})
      : super(key: key);

  static const dayNameStyle = TextStyle(
      fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold);
  static const defaultDayNameStyle =
      TextStyle(fontSize: 16, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:15, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(left:5, right: 5),
            //child: Text(tempDay.toString() + 'C', style: TextStyle(fontWeight: FontWeight.bold),)
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(text: tempDay.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "°C"),
              ]),
            )
          ),
          //Text("what")
          //https://stackoverflow.com/questions/60019684/use-gradient-with-paint-object-in-flutter-canvas
          // ^ gradient painter line

        ],
      )


    );
  }
}
