///WeatherRepository'nin temel amacı, veri sağlayıcıyı SOYUTLAYAN bir arayüz sağlamaktır. Bu durumda, WeatherRepository, WeatherApiClient(CollectApiClient)'e bağımlı olacak ve getWeather(String city) adlı tek bir genel yöntemi kullanıma sunacaktır.
///Yani CollectApiClientdan gelen iki methodu birleştirip tek bir methoda indirgeyeceğiz.

///WeatherRepository tüketicileri, metaweather API'sine iki ağ isteğinin yapılması gerçeği gibi temel uygulama ayrıntılarına hakim değildir. WeatherRepository'nin amacı "ne"yi "nasıl"dan AYIRMAK - başka bir deyişle, belirli bir şehir için HAVA DURUMUNU NASIL ALACAĞIMIZI BİLMEMİZ GEREKİR, ancak bu verilerin nasıl veya nereden geldiğini umursamayız.

import 'dart:async';

import 'package:weather_frontend/data/weather_api/collectapi_weather.dart';

class WeatherRepository {
  WeatherRepository({CollectApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? CollectApiClient();

  final CollectApiClient _weatherApiClient;

  Future<Weather> getWeather(String city) async {
    final weather = await _weatherApiClient.getWeather(city);

    return Weather(
      date: weather.date,
      day: weather.day,
      icon: weather.icon,
      description: weather.description,
      status: weather.status,
      degree: weather.degree,
      min: weather.min,
      max: weather.max,
      night: weather.night,
      humidity: weather.humidity,
    );
  }

  Future<List<Weather>> getWeatherList(String cityName) async {
    final weatherList = await _weatherApiClient.getWeatherList(cityName);
    return weatherList
        .map(
          (weather) => Weather(
            date: weather.date,
            day: weather.day,
            icon: weather.icon,
            description: weather.description,
            status: weather.status,
            degree: weather.degree,
            min: weather.min,
            max: weather.max,
            night: weather.night,
            humidity: weather.humidity,
          ),
        )
        .toList();
  }
}
