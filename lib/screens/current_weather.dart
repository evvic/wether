import 'dart:convert'; // JSON converters
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:mobile_weather_app/functions/get_api_key.dart'; //contains api key
import 'package:mobile_weather_app/functions/get_location.dart';
import 'package:mobile_weather_app/main.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/screens/forecast.dart';
import 'package:http/http.dart' as http;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:location/location.dart';

class CurrentWeatherOnly extends ConsumerStatefulWidget {
  const CurrentWeatherOnly({Key? key}) : super(key: key);

  @override
  _CurrentWeatherOnly createState() => _CurrentWeatherOnly();
}

class _CurrentWeatherOnly extends ConsumerState<CurrentWeatherOnly> {
  var weather_data;
  String? error_code = null;
  // location
  //static Coordinates coordinates = Coordinates();

  @override
  void initState() {
    super.initState();
    // read in providers
    ref.read(coordinateNotifier);

    getLocation(fetchWeather, container.read(coordinateNotifier)); //temp values
  }

  @override
  void dispose() {
    super.dispose();
    // disposing the globally self managed container.
    container.dispose();
  }

  // ignore: prefer_function_declarations_over_variables
  fetchWeather(double lat, double long) async {
    setState(() {
      error_code = null;
    });
    
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${get_api_key()}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // good response

        var weatherData = json.decode(response.body);

        setState(() {
          weather_data = weatherData;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        error_code = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final coordinate = ref.watch(coordinateNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Weather"),
      ),
      body: weather_data == null
          ? ((error_code == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Text(error_code!),
                      ElevatedButton(
                        child: const Text('Get location'),
                        onPressed: () {
                          // fetch data from internet
                          getLocation(
                              fetchWeather,
                              container.read(
                                  coordinateNotifier)); //no arrow function needed here
                          print("Enter onPressed");
                        },
                      ),
                    ]))))
          : RefreshIndicator(
              onRefresh: () =>
                  getLocation(fetchWeather, container.read(coordinateNotifier)),
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
                          fetchWeather,
                          container.read(
                              coordinateNotifier)); //no arrow function needed here
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
