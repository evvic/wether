import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/screens/forecast.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';

import '../main.dart';

appBarUni(BuildContext context, {required bool inForecast}) => AppBar(
  automaticallyImplyLeading: false,
    title: Text(container.read(coordinateNotifier).location.toString(),
        style: TextStyle(color: Colors.black)),
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    ),
    actions: [
      CupertinoButton(
          child: (inForecast) ? Text("Weather") : Text("Forecast"),
          onPressed: () {
            if (inForecast) {
              //forecast screen
              Navigator.pop(context);
            } else {
              // weather screen
              Navigator.push(
                  context,
                  // class we use to change to another page
                  MaterialPageRoute(
                      builder: (context) => WeatherForecastScreen()));
            }
          })
      //icon: Icon(Icons.save),
      //label: 'Save');
    ],
  );
