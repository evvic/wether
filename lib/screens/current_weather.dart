import 'dart:convert'; // JSON converters
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mobile_weather_app/functions/get_api_key.dart'; //contains api key
import 'package:mobile_weather_app/functions/get_location.dart';
import 'package:mobile_weather_app/screens/forecast.dart';
import 'package:http/http.dart' as http;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:location/location.dart';

class CurrentWeatherOnly extends StatefulWidget {
  const CurrentWeatherOnly({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherOnly> createState() => _CurrentWeatherOnly();
}

class _CurrentWeatherOnly extends State<CurrentWeatherOnly> {
  String cityName = "Bangkok";
  String currentWeather = "Sunny";
  double temp = 0;
  double windSpeed = 0;
  String icon = "01n";
  // location
  //var location = new Location();
  double latitude = 0.0;
  double longitude = 0.0;
  // has loaded?
  bool loaded = false;

  // ignore: prefer_function_declarations_over_variables
  fetchWeather(double lat, double long) async {
    Uri url = Uri.parse(
        //"https://api.openweathermap.org/data/2.5/weather?q=$city&appid=6c433438776b5be4ac86001dc88de74d");
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${get_api_key()}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // good response

      var weatherData = json.decode(response.body);

      this.setState(() {
        cityName = weatherData["name"];
        temp = weatherData['main']['temp'] - 273.15;
        currentWeather = weatherData['weather'][0]['description'];
        windSpeed = weatherData['wind']['speed'];
        icon = weatherData['weather'][0]['icon'];
        latitude = lat;
        longitude = long;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cityName),
      ),
      body: loaded == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => getLocation(fetchWeather),
              child: SingleChildScrollView(
                  child: Column(
                // evenly space all children vertically on the one screen
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(currentWeather, style: TextStyle(fontSize: 40)),
                  Image.network(
                    'https://openweathermap.org/img/wn/$icon.png',
                    scale: 0.8,
                  ),
                  Text(temp.toStringAsFixed(2) + " C",
                      style: TextStyle(fontSize: 40)),
                  Text("$windSpeed m/s", style: TextStyle(fontSize: 40)),
                  Text(latitude.toString() + ', ' + longitude.toString()),
                  ElevatedButton(
                    child: const Text('Get location'),
                    onPressed: () {
                      // fetch data from internet
                      getLocation(fetchWeather); //no arrow function needed here
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
                                  const WeatherForecastScreen()));
                    },
                  ),
                ],
              ))),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

// use a StatefulBuilder for very small and rapid state changes.
// i.e. if the direction the phone is turning keeps changing and an arrow
// is rotating to match the direction on the UI
