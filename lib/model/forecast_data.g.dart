// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastData _$ForecastDataFromJson(Map<String, dynamic> json) => ForecastData(
      temp_day: json['temp_day'] as int,
      temp_min: json['temp_min'] as int,
      temp_max: json['temp_max'] as int,
      desc_main: json['desc_main'] as String,
      desc_desc: json['desc_desc'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$ForecastDataToJson(ForecastData instance) =>
    <String, dynamic>{
      'temp_day': instance.temp_day,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'desc_main': instance.desc_main,
      'desc_desc': instance.desc_desc,
      'icon': instance.icon,
    };
