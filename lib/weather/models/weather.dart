import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

///This is the third different type of weather model we're implementing.

///1. Weather Model
///In the API client, our weather model contained all the info returned by the API.

///2. Weather Model
/// In the repository layer, our weather model contained only the abstracted model based on our business case.

///3. Weather Model
/// In this layer, our weather model will contain relevant information needed SPECIFICALLY for the CURRENT FEATURE SET. The goal of our this weather model is to keep track of weather data displayed by our app, AS WELL AS(yanı sıra) TEMPERATURE settings
@JsonSerializable()
class Weather extends Equatable {
  final WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final Degree degree;

  const Weather({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.degree,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      condition: weather.condition,
      lastUpdated: DateTime.now(),
      location: weather.location,
      degree: Degree(value: weather.degree),
    );
  }

  @override
  List<Object> get props => [condition, lastUpdated, location, degree];

  Weather copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    String? location,
    Degree? temperature,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      degree: temperature ?? this.degree,
    );
  }

  static final empty = Weather(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    degree: const Degree(value: 0),
    location: '--',
  );
}

@JsonSerializable()
class Degree extends Equatable {
  final double value;

  const Degree({required this.value});

  factory Degree.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  @override
  List<Object> get props => [value];
}
