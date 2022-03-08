import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_weather_app/model/weather_data.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  Weather({
    required this.data,
  });

  WeatherData data;

  factory Weather.fromRawJson(String str) => Weather.fromJson(json.decode(str));

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        data: WeatherData.fromJson(json["data"]),
      );
}