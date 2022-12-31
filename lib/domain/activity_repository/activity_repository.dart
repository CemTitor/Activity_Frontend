import 'dart:async';
import 'package:activity_frontend/data/activity_api/activity_api.dart';

///ActivityRepository'nin amacı "ne"yi "nasıl"dan AYIRMAK - başka bir deyişle, Activity'i NASIL alacağımızı bilmemiz gerekir, ancak bu verilerin nereden geldiğini umursamayız.

class ActivityRepository {
  ActivityRepository({ActivityApiClient? activityApiClient})
      : _activityApiClient = activityApiClient ?? ActivityApiClient();

  final ActivityApiClient _activityApiClient;

  Future<List<Activity>> getActivityList() async {
    return await _activityApiClient.getActivityList();
  }

  Stream<List<Activity>> getActivityListasStream() {
    return _activityApiClient.getActivityListasStream();
  }

  Future<void> addActivity(Activity activity) async {
    await _activityApiClient.postActivity(activity);
  }

  Future<void> updateActivity(Activity activity) async {
    await _activityApiClient.putActivity(activity);
  }

  Future<void> removeActivity(String id, String activityTitle) async {
    await _activityApiClient.deleteActivity(id, activityTitle);
  }
}
