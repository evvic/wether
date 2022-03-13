// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/screens/current_weather.dart';

// container for coordinates
final container = ProviderContainer();

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Navigation Basics',
      home: CurrentWeatherOnly(),
      theme: ThemeData(
          //colorSchemeSeed:
          ),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
