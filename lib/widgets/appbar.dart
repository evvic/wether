import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/screens/forecast.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';

class AppBarUni extends StatelessWidget {
  var data;
  String title = "Weather";
  String move = "Forecast";
  WidgetRef? ref;

  AppBarUni();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        CupertinoButton(
            child: Text(move),
            onPressed: () {
              if (move == "Forecast") {
                // in weather pushing to forecast
                Navigator.push(
                    context,
                    // class we use to change to another page
                    MaterialPageRoute(
                        builder: (context) => WeatherForecastScreen()));
              } else {
                // in Forecast going back to weather
                Navigator.pop(context);
              }
            })
        //icon: Icon(Icons.save),
        //label: 'Save');
      ],
    );
  }
}
