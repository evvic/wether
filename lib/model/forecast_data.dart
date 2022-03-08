import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// run the build runner to generate toJson() method:
//flutter pub run build_runner serve --delete-conflicting-outputs

part 'forecast_data.g.dart';

@JsonSerializable()
class ForecastData {

  ForecastData({
    required this.temp_day,
    required this.temp_min,
    required this.temp_max,
    required this.desc_main,
    required this.desc_desc,
    required this.icon,
  });

  int temp_day;
  int temp_min;
  int temp_max;
  String desc_main;
  String desc_desc;
  String icon;

  factory ForecastData.fromRawJson(String str) =>
      ForecastData.fromJson(json.decode(str));

  factory ForecastData.fromJson(Map<String, dynamic> json) => ForecastData(
        temp_day: json["temp"]["day"],
        temp_min: json["temp"]["day"],
        temp_max: json["temp"]["day"],
        desc_main: json["weather"][0]["main"],
        desc_desc: json["weather"][0]["description"],
        icon: json["weather"][0]["icon"],
      );
}