import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_frontend/data/weather_api/collectapi_weather.dart';
import 'package:weather_frontend/domain/weather_repository/src/weather_repository.dart';

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

  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}
