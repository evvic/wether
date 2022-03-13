import 'dart:convert'; // JSON converters
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:mobile_weather_app/providers/weather_provider.dart';
import 'package:mobile_weather_app/services/get_api_key.dart'; //contains api key
import 'package:mobile_weather_app/services/location_services.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/screens/forecast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/widgets/appbar.dart';
import 'package:mobile_weather_app/widgets/weather_loaded.dart';
import 'package:mobile_weather_app/widgets/weather_error.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:location/location.dart';

import '../main.dart';

//andoid color theme
//https://fredgrott.medium.com/android-12-dynamic-colors-in-flutter-apps-d6c3848f5e6c

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
  String appBarTitle = "Weather";

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

  // to refresh data
  _refresh(WidgetRef ref) async {
    try {
      ref.refresh(weatherProvider);
      return await ref.read(weatherProvider.future);
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    // create weatherProvider functionality
    // copy forecast methodology
    final config = ref.watch(weatherProvider);

    //final titleEl = ref.watch(coordinateNotifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarUni(context, inForecast: false),
      body: RefreshIndicator(
          displacement: 150,
          color: const Color.fromRGBO(100, 100, 100, 100),
          onRefresh: () => _refresh(ref),
          // top padding to offset extendBodyBehindAppBar
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: config.when(
                  data: (data) => WeatherLoaded(data: data, ref: ref),
                  error: (err, stack) => WeatherError(
                      message: err.toString(), refresh_: _refresh, ref: ref),
                  loading: () => const Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ))),
            ),
          )),
    );
  }
}

// use a StatefulBuilder for very small and rapid state changes.
// i.e. if the direction the phone is turning keeps changing and an arrow
// is rotating to match the direction on the UI