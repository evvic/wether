import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_heading.dart';
import 'package:mobile_weather_app/widgets/weather_loaded/loaded_temp_extrema.dart';

class WeatherLoaded extends StatelessWidget {
  var data;
  WidgetRef ref;

  WeatherLoaded({required this.data, required this.ref});

  static const IconData arrow_upward = IconData(0xe0a0, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // no fucking way it actually refreshse
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            // container for horizontal icon and temp
            LoadedHeading(temp: 25, description: "Cloudy", icon: "10d"),
            LoadedTempExtrema(min: 15, max: 34),
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
