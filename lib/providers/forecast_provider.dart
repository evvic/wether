import 'dart:convert';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/functions/get_api_key.dart';
import 'package:mobile_weather_app/functions/get_location.dart';
import 'package:mobile_weather_app/main.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:http/http.dart' as http;

class ForecastProvider extends ChangeNotifier {
  var forecast_item;
  // extarcted items
  int celsius = 0;
  String description = "temp desc";

  // basic constructor
  ForecastProvider(var item) {
    forecast_item = item;
  }

  set setData(var data) {
    forecast_item = data;
    notifyListeners();
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
final forecastProvider = FutureProvider<List<ForecastProvider>>((ref) async {
  if (getLocationLite() == 0) {
    // cannot get coordinaates. terminate
    //
  }

  double lat = container.read(coordinateNotifier).latitude;
  double long = container.read(coordinateNotifier).latitude;

  Uri url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$long&cnt=10&appid=${get_api_key()}");
  final response = await http.get(url);

  if (response.statusCode != 200) {
    // bad response
    // return
  }

  //final List vals = ;

  final obj = await json.decode(response.body);

  // init ret n declaration with first val
  List<ForecastProvider> ret = []; //[ForecastProvider(obj["list"][0])];
  //ret = await obj["list"];


  for (var item in obj["list"]) {
    ret.add(ForecastProvider(item));
  }
  
  //ForecastProvider.setForecast(content);

  print("return value of forecast provider:");
  //print(ret);

  // remove duplicate 1st item
  //ret.removeAt(0);

  return Future.value(ret);
});
