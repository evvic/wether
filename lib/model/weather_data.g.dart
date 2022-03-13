// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      tempDay: json['tempDay'] as int,
      tempMin: json['tempMin'] as int,
      tempMax: json['tempMax'] as int,
      tempFeels: json['tempFeels'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDir: json['windDir'] as int,
      humidity: json['humidity'] as int,
      pressure: json['pressure'] as int,
      descMain: json['descMain'] as String,
      descDesc: json['descDesc'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'tempDay': instance.tempDay,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'tempFeels': instance.tempFeels,
      'windSpeed': instance.windSpeed,
      'windDir': instance.windDir,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'descMain': instance.descMain,
      'descDesc': instance.descDesc,
      'icon': instance.icon,
    };
