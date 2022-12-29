///WeatherRepository'nin temel amacı, veri sağlayıcıyı SOYUTLAYAN bir arayüz sağlamaktır. Bu durumda, WeatherRepository, WeatherApiClient(CollectApiClient)'e bağımlı olacak ve getWeather(String city) adlı tek bir genel yöntemi kullanıma sunacaktır.
///Yani CollectApiClientdan gelen iki methodu birleştirip tek bir methoda indirgeyeceğiz.

///WeatherRepository tüketicileri, metaweather API'sine iki ağ isteğinin yapılması gerçeği gibi temel uygulama ayrıntılarına hakim değildir. WeatherRepository'nin amacı "ne"yi "nasıl"dan AYIRMAK - başka bir deyişle, belirli bir şehir için HAVA DURUMUNU NASIL ALACAĞIMIZI BİLMEMİZ GEREKİR, ancak bu verilerin nasıl veya nereden geldiğini umursamayız.

import 'dart:async';

import 'package:weather_frontend/data/activity_api/activity_api.dart';

class ActivityRepository {
  ActivityRepository({ActivityApiClient? activityApiClient})
      : _activityApiClient = activityApiClient ?? ActivityApiClient();

  final ActivityApiClient _activityApiClient;

  Future<List<Activity>> getActivityList() async {
    final activityList = await _activityApiClient.getActivityList();

    return activityList
        .map((e) => Activity(
              id: e.id,
              title: e.title,
              description: e.description,
              category: e.category,
              city: e.city,
              venue: e.venue,
            ))
        .toList();
  }

  Future<void> addActivity(Activity activity) async {
    await _activityApiClient.postActivity(activity);
  }

  Future<void> updateActivity(Activity activity) async {
    await _activityApiClient.putActivity(activity);
  }

  Future<void> removeActivity(String id) async {
    final activity = await _activityApiClient.deleteActivity(id);
  }
}
