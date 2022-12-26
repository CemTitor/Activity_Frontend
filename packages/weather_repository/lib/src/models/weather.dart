///We will be creating a new weather.dart file to expose a DOMAIN-SPECIFIC weather model. This model will contain ONLY DATA RELEVANT to our business cases -- in other words it should be completely DECOUPLED from the API client and raw data format.
///(Bu model YALNIZCA business casele ilgili verileri içermelidir - yani API istemcisinden ve ham veri biçiminden TAMAMEN AYRILMALIDIR.)

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

///2. Weather Model
/// In the repository layer, our weather model contained only the abstracted model BASED ON our BUSINESS CASE.
@JsonSerializable()
class Weather extends Equatable {
  final String date;
  final String day;
  final String icon;
  final String description;
  final String status;
  // final String degree;
  final String min;
  final String max;
  final String night;
  final String humidity;
  // final WeatherCondition condition;

  const Weather({
    required this.date,
    required this.day,
    required this.icon,
    required this.description,
    required this.status,
    // required this.degree,
    required this.min,
    required this.max,
    required this.night,
    required this.humidity,
    // required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object> get props => [
        date,
        day,
        icon,
        description,
        status,
        // degree,
        min,
        max,
        night,
        humidity,
        // condition
      ];
}
