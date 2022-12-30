// import 'package:json_annotation/json_annotation.dart';
//
// part 'weather.g.dart';
//
// @JsonSerializable()
// class Weather {
//   // final int id;
//   final String date;
//   final String day;
//   final String icon;
//   final String description;
//   final String status;
//   final String degree;
//   final String min;
//   final String max;
//   final String night;
//   final String humidity;
//
//   const Weather({
//     // required this.id,
//     required this.date,
//     required this.day,
//     required this.icon,
//     required this.description,
//     required this.status,
//     required this.degree,
//     required this.min,
//     required this.max,
//     required this.night,
//     required this.humidity,
//   });
//
//   factory Weather.fromJson(Map<String, dynamic> json) =>
//       _$WeatherFromJson(json);
// }

import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final String date;
  final String day;
  final String icon;
  final String description;
  final String status;
  final String degree;
  final String min;
  final String max;
  final String night;
  final String humidity;

  const Weather({
    required this.date,
    required this.day,
    required this.icon,
    required this.description,
    required this.status,
    required this.degree,
    required this.min,
    required this.max,
    required this.night,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  List<Object?> get props => [
        date,
        day,
        icon,
        description,
        status,
        degree,
        min,
        max,
        night,
        humidity,
      ];

  Weather copyWith({
    String? date,
    String? day,
    String? icon,
    String? description,
    String? status,
    String? degree,
    String? min,
    String? max,
    String? night,
    String? humidity,
  }) {
    return Weather(
      date: date ?? this.date,
      day: day ?? this.day,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      status: status ?? this.status,
      degree: degree ?? this.degree,
      min: min ?? this.min,
      max: max ?? this.max,
      night: night ?? this.night,
      humidity: humidity ?? this.humidity,
    );
  }

  static final empty = Weather(
    date: '',
    day: '',
    icon: '',
    description: '',
    status: '',
    degree: '',
    min: '',
    max: '',
    night: '',
    humidity: '',
  );

  factory Weather.fromRepository(Weather movie) {
    return Weather(
      date: movie.date,
      day: movie.day,
      icon: movie.icon,
      description: movie.description,
      status: movie.status,
      degree: movie.degree,
      min: movie.min,
      max: movie.max,
      night: movie.night,
      humidity: movie.humidity,
    );
  }
}
