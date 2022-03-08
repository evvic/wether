

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_weather_app/model/weather.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/screens/forecast.dart';

import '../main.dart';

class WeatherPageLoaded extends StatelessWidget {
  final Weather weather;
  final TextEditingController _weatherController = TextEditingController();

  WeatherPageLoaded({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
                // evenly space all children vertically on the one screen
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // city name //
                  Text(weather.data.city),
                  // short weather desc //
                  Text(weather.data.desc_desc,
                      style: TextStyle(fontSize: 40)),
                  // icon loaded //
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.data.icon}.png',
                    scale: 0.8,
                  ),
                  // temperature (celcius) //
                  Text(
                      (weather.data.temp_cur - 273.15)
                              .toStringAsFixed(2) +
                          " C",
                      style: TextStyle(fontSize: 40)),
                  // wind speed m/s //
                  Text("${weather.data.wind_sp} m/s",
                      style: TextStyle(fontSize: 40)),
                  // lat & long //
                  Text(container.read(coordinateNotifier).latitude.toString()),
                  ElevatedButton(
                    child: const Text('Get location'),
                    onPressed: () {
                      // fetch data from internet
                      //getLocation(fetchWeather); //no arrow function needed here
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
              ),
      ),
    );
  }
}