// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather',
      json,
      ($checkedConvert) {
        final val = Weather(
          id: $checkedConvert('id', (v) => v as int),
          date: $checkedConvert('date', (v) => v as String),
          day: $checkedConvert('day', (v) => v as String),
          icon: $checkedConvert('icon', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          degree: $checkedConvert('degree', (v) => v as String),
          min: $checkedConvert('min', (v) => v as String),
          max: $checkedConvert('max', (v) => v as String),
          night: $checkedConvert('night', (v) => v as String),
          humidity: $checkedConvert('humidity', (v) => v as String),
        );
        return val;
      },
    );
