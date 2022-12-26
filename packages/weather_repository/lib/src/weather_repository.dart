///WeatherRepository'nin temel amacı, veri sağlayıcıyı SOYUTLAYAN bir arayüz sağlamaktır. Bu durumda, WeatherRepository, WeatherApiClient(CollectApiClient)'e bağımlı olacak ve getWeather(String city) adlı tek bir genel yöntemi kullanıma sunacaktır.
///Yani CollectApiClientdan gelen iki methodu birleştirip tek bir methoda indirgeyeceğiz.

///WeatherRepository tüketicileri, metaweather API'sine iki ağ isteğinin yapılması gerçeği gibi temel uygulama ayrıntılarına hakim değildir. WeatherRepository'nin amacı "ne"yi "nasıl"dan AYIRMAK - başka bir deyişle, belirli bir şehir için HAVA DURUMUNU NASIL ALACAĞIMIZI BİLMEMİZ GEREKİR, ancak bu verilerin nasıl veya nereden geldiğini umursamayız.

import 'dart:async';

import 'package:collectapi_weather/collectapi_weather.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherRepository {
  WeatherRepository({CollectApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? CollectApiClient();

  final CollectApiClient _weatherApiClient;

  Future<Weather> getWeather(String city) async {
    print('önce');
    final weather = await _weatherApiClient.getWeather(city);
    print('sonra');
    print(weather);

    return Weather(
      date: weather.date,
      day: weather.day,
      icon: weather.icon,
      description: weather.description,
      status: weather.status,
      // degree: weather.degree,
      min: weather.min,
      max: weather.max,
      night: weather.night,
      humidity: weather.humidity,
      // condition: weather.weatherCode.toInt().toCondition,
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
            // degree: weather.degree,
            min: weather.min,
            max: weather.max,
            night: weather.night,
            humidity: weather.humidity,
            // condition: weather.weatherCode.toInt().toCondition,
          ),
        )
        .toList();
  }
}

// extension on int {
//   WeatherCondition get toCondition {
//     switch (this) {
//       case 0:
//         return WeatherCondition.clear;
//       case 1:
//       case 2:
//       case 3:
//       case 45:
//       case 48:
//         return WeatherCondition.cloudy;
//       case 51:
//       case 53:
//       case 55:
//       case 56:
//       case 57:
//       case 61:
//       case 63:
//       case 65:
//       case 66:
//       case 67:
//       case 80:
//       case 81:
//       case 82:
//       case 95:
//       case 96:
//       case 99:
//         return WeatherCondition.rainy;
//       case 71:
//       case 73:
//       case 75:
//       case 77:
//       case 85:
//       case 86:
//         return WeatherCondition.snowy;
//       default:
//         return WeatherCondition.unknown;
//     }
//   }
// }
