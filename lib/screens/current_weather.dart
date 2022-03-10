import 'dart:convert'; // JSON converters
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:mobile_weather_app/providers/weather_provider.dart';
import 'package:mobile_weather_app/services/get_api_key.dart'; //contains api key
import 'package:mobile_weather_app/services/location_services.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/screens/forecast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/widgets/weather_page_initial.dart';
import 'package:mobile_weather_app/widgets/weather_page_loaded.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:location/location.dart';

import '../main.dart';

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

    getLocation(fetchWeather); //temp values
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


    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {

          final state = ref.watch(weatherNotifierProvider);

          // figure out how to refactor this>>>>>>
          // so state works properly
          if (state != null) {
            return state.when(
              () => WeatherPageInitial(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (data) => WeatherPageLoaded(weather: data),
              error: (message) => (err, stack) => Text('Error: $err'),
            );
          } else {
            return const Text("null state error");
          }
        },
      ),
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

class CurrentWeatherOnly2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final state = watch(userNotifierProvider.state);

          return state.when(
            () => HomePageInitial(),
            loading: () => HomePageLoading(),
            loaded: (userInfo) => HomePageLoaded(user: userInfo),
            error: (message) => HomePageError(message: message),
          );
        },
      ),
    );
  }
}