import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'forecast_day.g.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs

@JsonSerializable()
class ForecastDayData {
  ForecastDayData({
    required this.tempDay,
    required this.tempMin,
    required this.tempMax,
    required this.tempFeels,
    required this.windSpeed,
    required this.windDir,
    required this.humidity,
    required this.pressure,
    required this.descMain,
    required this.descDesc,
    required this.icon,
  });

  int tempDay;
  int tempMin;
  int tempMax;
  int tempFeels;

  double windSpeed;
  int windDir;

  int humidity;

  int pressure;

  String descMain;
  String descDesc;
  String icon;

  factory ForecastDayData.fromRawJson(String str) =>
      ForecastDayData.fromJson(json.decode(str));

  factory ForecastDayData.fromJsonOld(Map<String, dynamic> json) =>
      ForecastDayData(
        tempDay: (json["temp"]["day"] - 273.15).round(), //celsius
        tempMin: (json["temp"]["min"] - 273.15).round(), //celsius
        tempMax: (json["temp"]["max"] - 273.15).round(), //celsius
        tempFeels: (json["feels_like"]["day"] - 273.15).round(), //celsius
        windSpeed: json["speed"], //m/s
        windDir: json["deg"], // degree
        humidity: json["humidity"], //percent
        pressure: json["pressure"], //hPa
        descMain: json["weather"][0]["main"],
        descDesc: json["weather"][0]["description"],
        icon: json["weather"][0]["icon"],
      );

  factory ForecastDayData.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayDataFromJson(json);

  Map<String, dynamic> toJson(obj) => _$ForecastDayDataToJson(this);
}
