import 'package:equatable/equatable.dart';
// import 'package:weather_frontend/weather/weather.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:weather_repository/weather_repository.dart'
//     show WeatherRepository;
import 'package:weather_frontend/data/weather_api/collectapi_weather.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

part 'weather_cubit.g.dart';
part 'weather_state.dart';

///We will use HydratedCubit to enable our app to REMEMBER its application state, even after it's been closed and reopened.
///HydratedCubit is an extension of Cubit which handles PERSISTING and RESTORING state across sessions

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherState());

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = Weather.fromRepository(
        await _weatherRepository.getWeather(city),
      );

      // final weather = await _weatherRepository.getWeather(city);
      // final units = state.degreeUnits;
      // final value = units.isFahrenheit
      //     ? weather.degree.value.toFahrenheit()
      //     : weather.degree.value;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          // degreeUnits: units,
          weather: weather.copyWith(day: weather.day),
          // weather: weather.copyWith(degree: Degree(value: value)),
        ),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> fetchWeatherList(String cityName) async {
    if (cityName.isEmpty) return;
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final weatherList = await _weatherRepository.getWeatherList(cityName);
      emit(state.copyWith(
        status: WeatherStatus.success,
        weatherList: weatherList,
      ));
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weather == Weather.empty) return;
    try {
      // final weather = Weather.fromRepository(
      //   await _weatherRepository.getWeather(state.weather.location),
      // );
      // final units = state.degreeUnits;
      // final value = units.isFahrenheit
      //     ? weather.degree.value.toFahrenheit()
      //     : weather.degree.value;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          // degreeUnits: units,
          // weather: weather.copyWith(degree: Degree(value: value)),
        ),
      );
    } on Exception {
      emit(state);
    }
  }

  // void toggleUnits() {
  //   final units = state.degreeUnits.isFahrenheit
  //       ? DegreeUnits.celsius
  //       : DegreeUnits.fahrenheit;
  //
  //   if (!state.status.isSuccess) {
  //     emit(state.copyWith(degreeUnits: units));
  //     return;
  //   }
  //
  //   final weather = state.weather;
  //   if (weather != Weather.empty) {
  //     // final temperature = weather.degree;
  //     // final value = units.isCelsius
  //     //     ? temperature.value.toCelsius()
  //     //     : temperature.value.toFahrenheit();
  //     emit(
  //       state.copyWith(
  //         degreeUnits: units,
  //         // weather: weather.copyWith(degree: Degree(value: value)),
  //       ),
  //     );
  //   }
  // }

  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}
