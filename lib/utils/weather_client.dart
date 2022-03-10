import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_weather_app/main.dart';
import 'package:mobile_weather_app/model/weather.dart';
import 'package:mobile_weather_app/model/weather_data.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/services/get_api_key.dart';
import 'package:mobile_weather_app/services/location_services.dart';
//import 'package:http/http.dart' as http;

class WeatherClient {
  late Dio _dio;

  Future<Weather?> fetchWeatherInfo() async {
    // get up to date location data
    var locData = await getLocationData();


    if (locData != null) {
      updateCoordinates(locData);

      // pull saved coordinates locally
      double? lat = container.read(coordinateNotifier).latitude;
      double? long = container.read(coordinateNotifier).latitude;

      BaseOptions options = BaseOptions(
        baseUrl: 'https://api.openweathermap.org/data/2.5/weather?',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          "Content-Type": 'application/json',
        },
      );

      _dio = Dio(options);

      Response response =
          await _dio.get("lat=$lat&lon=$long&cnt=10&appid=${get_api_key()}");

      if (response.statusCode == 200) {
        Weather weather = Weather.fromJson(response.data);

        return weather;
      }
    }

    return null;
  }
}
