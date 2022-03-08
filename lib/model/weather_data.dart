import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_weather_app/model/weather.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {

  WeatherData({
    required this.temp_cur,
    required this.temp_min,
    required this.temp_max,
    required this.wind_sp,
    required this.wind_dg,
    required this.desc_main,
    required this.desc_desc,
    required this.icon,
    required this.city,
  });

/*
  WeatherData.a(Weather d) {
    this.temp_cur json["main"]["temp"]
    this.temp_min,
    this.temp_max,
    this.wind_sp,
    this.wind_dg,
    this.desc_main,
    required this.desc_desc,
    required this.icon,
    required this.city,
  }; */

  // ignore: non_constant_identifier_names
  int temp_cur;
  int temp_min;
  int temp_max;
  int wind_sp;
  int wind_dg;
  String desc_main;
  String desc_desc;
  String icon;
  String city;

  factory WeatherData.fromRawJson(String str) =>
      WeatherData.fromJson(json.decode(str));

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        temp_cur: json["main"]["temp"],
        temp_min: json["main"]["temp"],
        temp_max: json["main"]["temp"],
        wind_sp: json["wind"]["speed"],
        wind_dg: json["wind"]["deg"],
        desc_main: json["weather"]["main"],
        desc_desc: json["weather"]["main"],
        icon: json["weather"]["icon"],
        city: json["city"],
      );
}
