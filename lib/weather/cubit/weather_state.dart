part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable()
class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final List<Weather> weatherList;
  // final DegreeUnits degreeUnits;

  WeatherState({
    this.status = WeatherStatus.initial,
    // this.degreeUnits = DegreeUnits.celsius,
    this.weatherList = const <Weather>[],
    Weather? weather,
  }) : weather = weather ?? Weather.empty;

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  WeatherState copyWith({
    WeatherStatus? status,
    // DegreeUnits? degreeUnits,
    Weather? weather,
    List<Weather>? weatherList,
  }) {
    return WeatherState(
      status: status ?? this.status,
      // degreeUnits: degreeUnits ?? this.degreeUnits,
      weather: weather ?? this.weather,
      weatherList: weatherList ?? this.weatherList,
    );
  }

  @override
  List<Object?> get props => [status, weather, weatherList];
}
