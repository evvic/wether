import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  WeatherData({
    required this.tempDay,
    required this.tempMin,
    required this.tempMax,
    required this.descMain,
    required this.descDesc,
    required this.icon,
  });

  int tempDay;
  int tempMin;
  int tempMax;
  String descMain;
  String descDesc;
  String icon;

  factory WeatherData.fromRawJson(String str) =>
      WeatherData.fromJson(json.decode(str));

  factory WeatherData.fromJsonOld(Map<String, dynamic> json) => WeatherData(
        tempDay: (json["main"]["temp"] - 273.15).round(),
        tempMin: (json["main"]["temp_min"] - 273.15).round(),
        tempMax: (json["main"]["temp_max"] - 273.15).round(),
        descMain: json["weather"][0]["main"],
        descDesc: json["weather"][0]["description"],
        icon: json["weather"][0]["icon"],
      );

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  Map<String, dynamic> toJson(obj) => _$WeatherDataToJson(this);
}
