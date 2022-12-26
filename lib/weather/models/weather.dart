// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:weather_repository/weather_repository.dart' hide Weather;
// import 'package:weather_repository/weather_repository.dart'
//     as weather_repository;
//
// part 'weather.g.dart';
//
// enum DegreeUnits { fahrenheit, celsius }
//
// extension degreeUnitsX on DegreeUnits {
//   bool get isFahrenheit => this == DegreeUnits.fahrenheit;
//   bool get isCelsius => this == DegreeUnits.celsius;
// }
//
// ///This is the third different type of weather model we're implementing.
//
// ///1. Weather Model
// ///In the API client, our weather model contained all the info returned by the API.
//
// ///2. Weather Model
// /// In the repository layer, our weather model contained only the abstracted model based on our business case.
//
// ///3. Weather Model
// /// In this layer, our weather model will contain relevant information needed SPECIFICALLY for the CURRENT FEATURE SET. The goal of our this weather model is to keep track of weather data displayed by our app, AS WELL AS(yanı sıra) TEMPERATURE settings
// @JsonSerializable()
// class Weather extends Equatable {
//   // final WeatherCondition condition;
//   // final Degree degree;
//   // final DateTime lastUpdated;
//   final String date;
//   final String day;
//   final String icon;
//   final String description;
//   final String status;
//   final String min;
//   final String max;
//   final String night;
//   final String humidity;
//
//   const Weather({
//     // required this.condition,
//     // required this.degree,
//     // required this.lastUpdated,
//     required this.date,
//     required this.day,
//     required this.icon,
//     required this.description,
//     required this.status,
//     required this.min,
//     required this.max,
//     required this.night,
//     required this.humidity,
//   });
//
//   factory Weather.fromJson(Map<String, dynamic> json) =>
//       _$WeatherFromJson(json);
//
//   Map<String, dynamic> toJson() => _$WeatherToJson(this);
//
//   factory Weather.fromRepository(weather_repository.Weather weather) {
//     return Weather(
//       // condition: weather.condition,
//       // degree: weather.degree,
//       // lastUpdated: DateTime.now(),
//       date: weather.date,
//       day: weather.day,
//       icon: weather.icon,
//       description: weather.description,
//       status: weather.status,
//       min: weather.min,
//       max: weather.max,
//       night: weather.night,
//       humidity: weather.humidity,
//     );
//   }
//
//   @override
//   // List<Object> get props => [condition, lastUpdated, degree];
//   List<Object> get props => [
//         date,
//         day,
//         icon,
//         description,
//         status,
//         min,
//         max,
//         night,
//         humidity,
//       ];
//
//   Weather copyWith({
//     // WeatherCondition? condition,
//     // Degree? degree,
//     // DateTime? lastUpdated,
//     String? date,
//     String? day,
//     String? icon,
//     String? description,
//     String? status,
//     String? min,
//     String? max,
//     String? night,
//     String? humidity,
//   }) {
//     return Weather(
//       // condition: condition ?? this.condition,
//       // degree: degree ?? this.degree,
//       // lastUpdated: lastUpdated ?? this.lastUpdated,
//       date: date ?? this.date,
//       day: day ?? this.day,
//       icon: icon ?? this.icon,
//       description: description ?? this.description,
//       status: status ?? this.status,
//       min: min ?? this.min,
//       max: max ?? this.max,
//       night: night ?? this.night,
//       humidity: humidity ?? this.humidity,
//     );
//   }
//
//   static final empty = Weather(
//     // condition: WeatherCondition.unknown,
//     // degree: Degree.celsius,
//     // lastUpdated: DateTime(0),
//     date: '',
//     day: '',
//     icon: '',
//     description: '',
//     status: '',
//     min: '',
//     max: '',
//     night: '',
//     humidity: '',
//   );
// }
//
// @JsonSerializable()
// class Degree extends Equatable {
//   final double value;
//
//   const Degree({required this.value});
//
//   factory Degree.fromJson(Map<String, dynamic> json) => _$DegreeFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DegreeToJson(this);
//
//   @override
//   List<Object> get props => [value];
// }
