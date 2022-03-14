import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/model/weather_data.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_api_logo.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_git_logo.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_heading.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_humidity.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_long_desc.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_temp_extrema.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_wind_pres_row.dart';

import '../main.dart';

class WeatherLoaded extends StatelessWidget {
  WeatherData data;
  WidgetRef ref;
  bool saved;

  WeatherLoaded({required this.data, required this.ref, required this.saved});

  static const IconData arrow_upward =
      IconData(0xe0a0, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // no fucking way it actually refreshse
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            // container for horizontal icon and temp
            LoadedHeading(
                temp: data.tempDay,
                description: data.descMain,
                icon: data.icon),
            // temp min and max card
            LoadedTempExtrema(min: data.tempMin, max: data.tempMax),
            // add long description here!!!
            LoadedLongDesc(description: data.descDesc),
            //humidy and feels like
            LoadedHumidity(
                percentage: data.humidity, feelsLike: data.tempFeels),
            LoadedWindPresRow(
                windSpeed: data.windSpeed,
                windDir: data.windDir,
                pressure: data.pressure),
            LoadedApiLogo(),
            LoadedGitLogo(),
            Text(saved.toString()),
            Text(container.read(coordinateNotifier).latitude.toString()),
            Text(container.read(coordinateNotifier).longitude.toString()),
          ],
        ));
    //Text(data.descMain))
  }
}

//
/*
RefreshIndicator(
  onRefresh: () =>
      getLocation(fetchWeather),
  child: SingleChildScrollView(
      child: Column(
    // evenly space all children vertically on the one screen
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // city name //
      Text(weather_data["name"]),
      // short weather desc //
      Text(weather_data['weather'][0]['description'],
          style: TextStyle(fontSize: 40)),
      // icon loaded //
      Image.network(
        'https://openweathermap.org/img/wn/${weather_data['weather'][0]['icon']}.png',
        scale: 0.8,
      ),
      // temperature (celcius) //
      Text(
          (weather_data['main']['temp'] - 273.15)
                  .toStringAsFixed(2) +
              " C",
          style: TextStyle(fontSize: 40)),
      // wind speed m/s //
      Text("${weather_data['wind']['speed']} m/s",
          style: TextStyle(fontSize: 40)),
      // lat & long //
      Text(container.read(coordinateNotifier).latitude.toString()),
      ElevatedButton(
        child: const Text('Get location'),
        onPressed: () {
          // fetch data from internet
          getLocation(
              fetchWeather); //no arrow function needed here
          print("Enter onPressed");
        },
      ),
      ElevatedButton(
        child: const Text('Forecast'),
        onPressed: () {
          // Navigate to second route when tapped.
          Navigator.push(
              context,
              // class we use to change to another page
              MaterialPageRoute(
                  builder: (context) => WeatherForecastScreen()));
        },
      ),
    ],
  ))),
              */
