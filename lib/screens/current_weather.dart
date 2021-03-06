import 'dart:convert'; // JSON converters
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:wether/model/weather_data.dart';
import 'package:wether/providers/weather_provider.dart';
import 'package:wether/services/error_services.dart';
import 'package:wether/services/get_api_key.dart'; //contains api key
import 'package:wether/services/location_services.dart';
import 'package:wether/providers/coordinate_provider.dart';
import 'package:wether/screens/forecast.dart';
import 'package:http/http.dart' as http;
import 'package:wether/widgets/appbar.dart';
import 'package:wether/widgets/weather_loaded.dart';
import 'package:wether/widgets/error_page.dart';

import '../main.dart';

//andoid color theme
//https://fredgrott.medium.com/android-12-dynamic-colors-in-flutter-apps-d6c3848f5e6c

class CurrentWeatherOnly extends ConsumerStatefulWidget {
  const CurrentWeatherOnly({Key? key}) : super(key: key);

  @override
  _CurrentWeatherOnly createState() => _CurrentWeatherOnly();
}

class _CurrentWeatherOnly extends ConsumerState<CurrentWeatherOnly> {
  WeatherData? savedData;
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
          savedData = weatherData;
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
  _refresh(WidgetRef ref, var fun) async {
    try {
      ref.refresh(weatherProvider);
      return await ref.read(weatherProvider.future);
    } catch (e) {
      fun("Error: " + errorNameToClass(e.toString()).suggestion);
    }
  }

  copySave(var w) {
    try {
      setState(() {
        savedData = w;
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  final snackBar = const SnackBar(content: Text("Error: cannot connect to internet"));

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
        onRefresh: () => _refresh(
            ref,
            (error) =>
                {ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.toString())))}),
        // top padding to offset extendBodyBehindAppBar
        //child: Padding(
        //  padding: const EdgeInsets.only(top: 60.0),
        //child: Center(
        child: config.when(
            // LOADED PAGE.
            data: (data) =>
                WeatherLoaded(data: data, ref: ref, saved: copySave(data)),
            // ERROR PAGE. If previous state is saved then continue to show old data
            // but show a Snack bar saying error message
            error: (err, stack) => (savedData != null)
                ? WeatherLoaded(data: savedData!, ref: ref, saved: false)
                : ErrorPage(
                    error: errorNameToClass(err.toString()),
                    refresh_: _refresh,
                    ref: ref),
            // LOADING PAGE. If previous state is saved then continue to show old data
            // while refresh indicator continues to show
            loading: () => (savedData != null)
                ? WeatherLoaded(data: savedData!, ref: ref, saved: false)
                : const Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ))),
        //),
        //)
      ),
    );
  }
}

// use a StatefulBuilder for very small and rapid state changes.
// i.e. if the direction the phone is turning keeps changing and an arrow
// is rotating to match the direction on the UI