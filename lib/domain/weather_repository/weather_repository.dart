import 'dart:async';
import 'package:activity_frontend/data/weather_api/collectapi_weather.dart';

class WeatherRepository {
  WeatherRepository({CollectApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? CollectApiClient();

  final CollectApiClient _weatherApiClient;

  Future<Weather> getWeather(String city) async {
    return await _weatherApiClient.getTodayWeatherForecastByCity(city);
  }

  Future<List<Weather>> getWeatherList(String cityName) async {
    return await _weatherApiClient.getWeeklyWeatherForecastByCity(cityName);
  }
}
