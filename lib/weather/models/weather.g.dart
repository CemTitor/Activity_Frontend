// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      date: json['date'] as String,
      day: json['day'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      min: json['min'] as String,
      max: json['max'] as String,
      night: json['night'] as String,
      humidity: json['humidity'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'date': instance.date,
      'day': instance.day,
      'icon': instance.icon,
      'description': instance.description,
      'status': instance.status,
      'min': instance.min,
      'max': instance.max,
      'night': instance.night,
      'humidity': instance.humidity,
    };

Degree _$DegreeFromJson(Map<String, dynamic> json) => Degree(
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$DegreeToJson(Degree instance) => <String, dynamic>{
      'value': instance.value,
    };
