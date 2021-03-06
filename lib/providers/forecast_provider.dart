import 'dart:async';
import 'dart:convert';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:wether/model/forecast_day.dart';
import 'package:wether/services/get_api_key.dart';
import 'package:wether/services/location_services.dart';
import 'package:wether/main.dart';
import 'package:wether/providers/coordinate_provider.dart';
import 'package:http/http.dart' as http;

class ForecastProvider {
  var forecast_item;
  // extarcted items
  int celsius = 0;
  String description = "temp desc";

  // basic constructor
  ForecastProvider(var item) {
    forecast_item = item;
    celsius = 6;
  }

  set setData(var data) {
    forecast_item = data;
    //notifyListeners();
  }

  /* getters */
  get getCelsius {
    return celsius;
  }

  get getDescription {
    return description;
  }
}

// instantiate the provider class
//final forecastNotifier = ChangeNotifierProvider<ForecastProvider>((ref) {
//  return ForecastProvider();
//});

// get coordiantes
final forecastProvider = FutureProvider<List<ForecastDayData>>((ref) async {
  // init ret n declaration with first val
  List<ForecastDayData> ret = [];

  try {
    LocationData? _locationData = await getLocationData();

    if (_locationData != null) {
      updateCoordinates(_locationData);
    }

    // pull save coordinates locally
    double? lat = container.read(coordinateNotifier).latitude;
    double? long = container.read(coordinateNotifier).longitude;

    if (_locationData == null && lat == null && long == null) {
      throw ErrorDescription("location services were not aquired.");
    }

    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$long&cnt=10&appid=${get_api_key()}");

    print("forecast URL: ");
    print(url);

    final response = await http.get(url);

    if (response.statusCode != 200) {
      // bad response
      // return
      return Future.error(response.statusCode.toString());
    }

    final obj = await json.decode(response.body);

    for (var item in obj["list"]) {
      ret.add(ForecastDayData.fromJsonOld(item));
    }
  } catch (e) {
    print("inside forecastProvider catch");
    return Future.error(e.toString());
    //throw AsyncValue.error(e.toString());
  }

  return Future.value(ret);
});

/*class FetchForecast {
  Future<List<ForecastProvider>> fetch() {}
} */



/* NEW METHOD CAUSE FUTURE PROVIDER IS BROKEN */

//final databaseProvider = Provider((ref) => ForecastDatabase());
