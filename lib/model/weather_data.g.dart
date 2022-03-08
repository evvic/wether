// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      temp_cur: json['temp_cur'] as int,
      temp_min: json['temp_min'] as int,
      temp_max: json['temp_max'] as int,
      wind_sp: json['wind_sp'] as int,
      wind_dg: json['wind_dg'] as int,
      desc_main: json['desc_main'] as String,
      desc_desc: json['desc_desc'] as String,
      icon: json['icon'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'temp_cur': instance.temp_cur,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'wind_sp': instance.wind_sp,
      'wind_dg': instance.wind_dg,
      'desc_main': instance.desc_main,
      'desc_desc': instance.desc_desc,
      'icon': instance.icon,
      'city': instance.city,
    };
