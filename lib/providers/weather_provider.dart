import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:mobile_weather_app/model/weather_data.dart';
import 'package:mobile_weather_app/services/error_services.dart';
import 'package:mobile_weather_app/services/get_api_key.dart';
import 'package:mobile_weather_app/services/location_services.dart';
import 'package:mobile_weather_app/main.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/widgets/weather_loaded.dart';

// instantiate the provider class
//final forecastNotifier = ChangeNotifierProvider<ForecastProvider>((ref) {
//  return ForecastProvider();
//});

// get coordiantes
final weatherProvider = FutureProvider<WeatherData>((ref) async {
  WeatherData ret;

  try {
    LocationData? _locationData = await getLocationData();

    if (_locationData != null) {
      updateCoordinates(_locationData);
    }

    // pull save coordinates locally
    double? lat = container.read(coordinateNotifier).latitude;
    double? long = container.read(coordinateNotifier).longitude;

    if (_locationData == null || lat == null && long == null) {
      //throw ErrorDescription("location services were not aquired.");
      return Future.error(LocationAccess().name);
    }

    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${get_api_key()}");

    print(url);

    final response = await http.get(url).timeout(const Duration(seconds: 5));

    if (response.statusCode != 200) {
      // bad response
      return Future.error(BadResponse().name);
    }

    final obj = await json.decode(response.body);

    saveLocation(obj["name"]);

    return Future.value(WeatherData.fromJsonOld(obj));
    
  } on TimeoutException catch (e) {
    return Future.error(TimeoutException().name);
  } on SocketException catch (e) {
    return Future.error(SocketException().name);
  } catch (e) {
    print("inside forecastProvider catch");
    return Future.error(UntrackedException().name);
  }
});

/*class FetchForecast {
  Future<List<ForecastProvider>> fetch() {}
} */



/* NEW METHOD CAUSE FUTURE PROVIDER IS BROKEN */

//final databaseProvider = Provider((ref) => ForecastDatabase());
