import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_frontend/data/activity_api/activity_api.dart';

class ActivityRequestFailure implements Exception {}

class ActivityNotFoundFailure implements Exception {}

class ActivityApiClient {
  ActivityApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const localhost = '10.0.2.2:7216';

  final http.Client _httpClient;

  // Future<List<Activity>> getActivityList() async {
  //   final activityRequest = Uri.https(
  //     localhost,
  //     '/Activity/GetAll',
  //   );
  //
  //   final activityResponse = await _httpClient.get(
  //     activityRequest,
  //   );
  //
  //   if (activityResponse.statusCode != 200) {
  //     throw ActivityRequestFailure();
  //   }
  //   final activityJson =
  //       jsonDecode(activityResponse.body) as Map<String, dynamic>;
  //
  //   final results = activityJson['result'] as List;
  //
  //   if (!activityJson.containsKey('result') || results.isEmpty) {
  //     throw ActivityNotFoundFailure();
  //   }
  //
  //   final activityList = results
  //       .map((activity) => Activity.fromJson(activity as Map<String, dynamic>))
  //       .toList();
  //
  //   print(activityList);
  //   return activityList;
  // }

  ///my method
  Future<List<Activity>> getActivityList() async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/GetAll',
    );
    print('activityRequest: $activityRequest');
    final activityResponse = await _httpClient.get(activityRequest);
    print('activityResponse: ${activityResponse.statusCode}');
    print('activityResponse: ${activityResponse.body}');
    print('activityResponse: ${activityResponse.headers}');
    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    final activityJson = jsonDecode(activityResponse.body);

    ActivityList activityList = ActivityList.fromJson(activityJson);

    if (activityList.activities.isEmpty) {
      throw ActivityNotFoundFailure();
    }

    print(activityList.activities);
    return activityList.activities;
  }

  Future<Activity> getActivityById(int id) async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/GetById',
      {'id': id.toString()},
    );
    print(activityRequest);
    final activityResponse = await _httpClient.get(activityRequest);
    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    print(activityResponse.body);
    final activityJson = jsonDecode(activityResponse.body);
    print(activityJson);

    return Activity.fromJson(activityJson);
  }

  ///Post Activity
  Future<Activity> postActivity(Activity activity) async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/Post',
    );
    print(activityRequest);
    final activityResponse = await _httpClient.post(activityRequest,
        body: jsonEncode(activity.toJson()));
    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    print(activityResponse.body);
    final activityJson = jsonDecode(activityResponse.body);
    print(activityJson);

    return Activity.fromJson(activityJson);
  }

  ///Put Activity
  Future<Activity> putActivity(Activity activity) async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/Put',
    );
    print(activityRequest);
    final activityResponse = await _httpClient.put(activityRequest,
        body: jsonEncode(activity.toJson()));
    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    print(activityResponse.body);
    final activityJson = jsonDecode(activityResponse.body);
    print(activityJson);

    return Activity.fromJson(activityJson);
  }

  ///Delete Activity
  Future<Activity> deleteActivity(int id) async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/Delete',
      {'id': id.toString()},
    );
    print(activityRequest);
    final activityResponse = await _httpClient.delete(activityRequest);
    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    print(activityResponse.body);
    final activityJson = jsonDecode(activityResponse.body);
    print(activityJson);

    return Activity.fromJson(activityJson);
  }
}
