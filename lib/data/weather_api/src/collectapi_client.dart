import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_frontend/data/weather_api/collectapi_weather.dart';

/// Exception thrown when locationSearch fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class WeatherNotFoundFailure implements Exception {}

/// Dart API Client which wraps the [CollectAPI](https://collectapi.com/).
class CollectApiClient {
  CollectApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlWeather = 'api.collectapi.com';
  static const String API_KEY = '4rkXCW1KgC5brStouAHSFJ:1MridwViwXGGFOJWHeC79N';

  final http.Client _httpClient;

  /// Finds a [Weather] `/weather/getWeather/?data.lang=(lang)&data.city=(city)`.
  Future<Weather> getWeather(String query) async {
    final weatherRequest = Uri.https(
      _baseUrlWeather,
      '/weather/getWeather',
      {'data.lang': 'tr', 'data.city': query},
    );

    final weatherResponse = await _httpClient.get(weatherRequest, headers: {
      'authorization': 'apikey 4rkXCW1KgC5brStouAHSFJ:1MridwViwXGGFOJWHeC79N',
      'content-type': 'application/json',
    });

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final weatherJson = jsonDecode(weatherResponse.body) as Map;

    if (!weatherJson.containsKey('result')) throw WeatherNotFoundFailure();

    final results = weatherJson['result'] as List;

    if (results.isEmpty) throw WeatherNotFoundFailure();

    return Weather.fromJson(results.first as Map<String, dynamic>);
  }

  Future<List<Weather>> getWeatherList(String cityName) async {
    final weatherRequest = Uri.https(
      _baseUrlWeather,
      '/weather/getWeather',
      {'data.lang': 'tr', 'data.city': cityName},
    );

    final weatherResponse = await _httpClient.get(weatherRequest, headers: {
      'authorization': 'apikey 4rkXCW1KgC5brStouAHSFJ:1MridwViwXGGFOJWHeC79N',
      'content-type': 'application/json',
    });

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }
    final weatherJson =
        jsonDecode(weatherResponse.body) as Map<String, dynamic>;
    final results = weatherJson['result'] as List;
    if (!weatherJson.containsKey('result') || results.isEmpty) {
      throw WeatherNotFoundFailure();
    }

    final weatherList = results
        .map((movie) => Weather.fromJson(movie as Map<String, dynamic>))
        .toList();

    print(weatherList);
    return weatherList;
  }
}
