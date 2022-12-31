import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:activity_frontend/data/activity_api/activity_api.dart';

class ActivityRequestFailure implements Exception {}

class ActivityNotFoundFailure implements Exception {}

class ActivityApiClient {
  ActivityApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client() {
    _init();
  }

  static const localhost = '10.0.2.2:7216';
  final http.Client _httpClient;

  ///Get all activities
  Future<List<Activity>> getActivityList() async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/GetAll',
    );
    print('activityRequest: $activityRequest');
    final activityResponse = await _httpClient.get(activityRequest);
    print('activityResponse: ${activityResponse.statusCode}');
    print('activityResponse: ${activityResponse.body}');
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

  final _activityStreamController =
      BehaviorSubject<List<Activity>>.seeded(const []);

  void _init() async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/GetAll',
    );
    print('activityRequest: $activityRequest');
    final activityResponse = await _httpClient.get(activityRequest);
    print('activityResponse: ${activityResponse.statusCode}');
    print('activityResponse: ${activityResponse.body}');
    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    final activityJson = jsonDecode(activityResponse.body);
    if (activityJson != null) {
      List<Activity> activityList = activityJson
          .map<Activity>((activityJson) => Activity.fromJson(activityJson))
          .toList();
      _activityStreamController.add(activityList);
    } else {
      _activityStreamController.add(const []);
    }
  }

  Stream<List<Activity>> getActivityListasStream() =>
      _activityStreamController.asBroadcastStream();

  ///Post Activity
  Future<Activity> postActivity(Activity activity) async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/Add',
    );
    final activityResponse = await _httpClient.post(
      activityRequest,
      body: jsonEncode(activity),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    print('activityRequest: ${activityRequest}');
    print('activityResponse: ${activityResponse.statusCode}');
    print('activityResponse: ${activityResponse.body}');
    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    final activityJson = jsonDecode(activityResponse.body);

    // final activities = [..._activityStreamController.value];
    // activities.add(activity);
    // _activityStreamController.add(activities);

    //todo:actually, I should not call init() method here. But I am doing this because I am creating Activity "ID" in the backend. So, I need to get the list from backend again.
    _init();
    return Activity.fromJson(activityJson);
  }

  ///Put Activity
  Future<Activity> putActivity(Activity activity) async {
    print('activity: ${activity.toJson()}');
    final activityRequest = Uri.http(
      localhost,
      '/Activity/Update',
    );
    final activityResponse = await _httpClient.put(
      activityRequest,
      body: jsonEncode(
        activity.toJson(),
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    print('activityRequest: ${activityRequest}');
    print('activityResponse: ${activityResponse.statusCode}');
    print('activityResponse: ${activityResponse.body}');
    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    final activityJson = jsonDecode(activityResponse.body);
    _init();

    return Activity.fromJson(activityJson);
  }

  ///Delete Activity
  Future<Activity> deleteActivity(String id, String activityTitle) async {
    final activityRequest = Uri.http(
      localhost,
      '/Activity/Delete/$id',
    );
    print('activityRequest: ${activityRequest}');
    final activityResponse = await _httpClient.delete(activityRequest);
    print('activityResponse: ${activityResponse.statusCode}');
    print('activityResponse: ${activityResponse.body}');

    if (activityResponse.statusCode != 200) {
      throw ActivityRequestFailure();
    }
    final activityJson = await jsonDecode(activityResponse.body);

    // final activities = [..._activityStreamController.value];
    // final activityIndex =
    //     activities.indexWhere((activity) => activity.title == activityTitle);
    // if (activityIndex == -1) {
    //   throw ActivityNotFoundFailure();
    // } else {
    //   activities.removeAt(activityIndex);
    //   _activityStreamController.add(activities);
    // }
    _init();

    return Activity.fromJson(activityJson);
  }

  ///Get Activity by Id
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
}
