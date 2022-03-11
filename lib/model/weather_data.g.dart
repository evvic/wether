// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      tempDay: json['tempDay'] as int,
      tempMin: json['tempMin'] as int,
      tempMax: json['tempMax'] as int,
      descMain: json['descMain'] as String,
      descDesc: json['descDesc'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'tempDay': instance.tempDay,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'descMain': instance.descMain,
      'descDesc': instance.descDesc,
      'icon': instance.icon,
    };
