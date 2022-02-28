import 'dart:convert'; // JSON converters
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_weather_app/functions/get_api_key.dart'; //contains api key
import 'package:mobile_weather_app/functions/get_location.dart';
import 'package:mobile_weather_app/screens/forecast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/store/coordinates/coordinates.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:location/location.dart';

class CurrentWeatherOnly extends StatefulWidget {
  const CurrentWeatherOnly({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherOnly> createState() => _CurrentWeatherOnly();
}

class _CurrentWeatherOnly extends State<CurrentWeatherOnly> {
  var weather_data;
  // location
  static Coordinates coordinates = Coordinates();

  @override
  void initState() {
    super.initState();
    getLocation(fetchWeather, coordinates); //temp values
  }

  // ignore: prefer_function_declarations_over_variables
  fetchWeather(double lat, double long) async {
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${get_api_key()}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // good response

      var weatherData = json.decode(response.body);

      setState(() {
        weather_data = weatherData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Weather"),
      ),
      body: weather_data == null || coordinates.longitude == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => getLocation(fetchWeather, coordinates),
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
                  //Text(latitude.toString() + ', ' + longitude.toString()),
                  Observer(
                      builder: (_) => Text(coordinates.latitude.toString() +
                          ', ' +
                          coordinates.longitude.toString())),
                  ElevatedButton(
                    child: const Text('Get location'),
                    onPressed: () {
                      // fetch data from internet
                      getLocation(fetchWeather, coordinates); //no arrow function needed here
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
                              builder: (context) =>
                                  WeatherForecastScreen()));
                    },
                  ),
                ],
              ))),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

// use a StatefulBuilder for very small and rapid state changes.
// i.e. if the direction the phone is turning keeps changing and an arrow
// is rotating to match the direction on the UI
