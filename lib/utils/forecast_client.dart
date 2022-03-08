import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:mobile_weather_app/main.dart';
import 'package:mobile_weather_app/model/forecast_data.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/services/get_api_key.dart';
import 'package:mobile_weather_app/services/location_services.dart';
import 'package:http/http.dart' as http;


class ForecastClient {

  Future<List<ForecastData>?> fetchForecastInfo(String userId) async {
    // get up to date location data
    var locData = await getLocationData();

    //init list of ForecastData
    List<ForecastData> ret = [];

    if(locData != null) {

      updateCoordinates(locData);

      // pull saved coordinates locally
      double? lat = container.read(coordinateNotifier).latitude;
      double? long = container.read(coordinateNotifier).latitude;

      Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$long&cnt=10&appid=${get_api_key()}");

      final response = await http.get(url);

      if (response.statusCode == 200) {

        final obj = await json.decode(response.body);

        for (var item in obj["list"]) {
          ret.add(ForecastData.fromJson(item));
        }

        return ret;
      }
    }

    return null;
  }
}
