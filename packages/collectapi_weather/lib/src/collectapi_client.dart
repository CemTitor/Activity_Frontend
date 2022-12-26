import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:collectapi_weather/collectapi_weather.dart';

/// Exception thrown when locationSearch fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class WeatherNotFoundFailure implements Exception {}

/// Dart API Client which wraps the [CollectAPI](https://collectapi.com/).
class CollectApiClient {
  CollectApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlWeather = 'https://api.collectapi.com';
  static const String API_KEY = '4rkXCW1KgC5brStouAHSFJ:1MridwViwXGGFOJWHeC79N';

  final http.Client _httpClient;

  /// Finds a [Weather] `/weather/getWeather/?data.lang=(lang)&data.city=(city)`.
  Future<Weather> getWeather(String query) async {
    final locationRequest = Uri.https(
      _baseUrlWeather,
      '/weather/getWeather',
      {
        'data.lang': 'tr',
        'data.city': query,
      },
    );

    final weatherResponse = await _httpClient.get(locationRequest, headers: {
      'content-type': 'application/json',
      'authorization': 'apikey $API_KEY'
    });

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final weatherJson = jsonDecode(weatherResponse.body) as Map;

    if (!weatherJson.containsKey('results')) throw WeatherNotFoundFailure();

    final results = weatherJson['results'] as List;

    if (results.isEmpty) throw WeatherNotFoundFailure();

    return Weather.fromJson(results.first as Map<String, dynamic>);
  }
  //
  // /// Fetches [Weather] for a given [latitude] and [longitude].
  // Future<Weather> getWeather({
  //   required double latitude,
  //   required double longitude,
  // }) async {
  //   final weatherRequest = Uri.https(_baseUrlWeather, 'v1/forecast', {
  //     'latitude': '$latitude',
  //     'longitude': '$longitude',
  //     'current_weather': 'true'
  //   });
  //
  //   final weatherResponse = await _httpClient.get(weatherRequest);
  //
  //   if (weatherResponse.statusCode != 200) {
  //     throw WeatherRequestFailure();
  //   }
  //
  //   final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;
  //
  //   if (!bodyJson.containsKey('current_weather')) {
  //     throw WeatherNotFoundFailure();
  //   }
  //
  //   final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;
  //
  //   return Weather.fromJson(weatherJson);
  // }
}
