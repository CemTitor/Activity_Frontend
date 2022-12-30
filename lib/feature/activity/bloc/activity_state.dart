part of 'activity_bloc.dart';

enum ActivityStatus { initial, loading, success, failure }

extension ActivityStatusX on ActivityStatus {
  bool get isInitial => this == ActivityStatus.initial;

  bool get isLoading => this == ActivityStatus.loading;

  bool get isSuccess => this == ActivityStatus.success;

  bool get isFailure => this == ActivityStatus.failure;
}

@JsonSerializable()
class ActivityState extends Equatable {
  final ActivityStatus status;
  final Activity activity;
  final List<Activity> activityList;
  final Activity? lastDeletedActivity;

  ActivityState({
    this.status = ActivityStatus.initial,
    this.activityList = const <Activity>[],
    Activity? activity,
    this.lastDeletedActivity,
  }) : activity = activity ?? Activity.empty;

  // factory ActivityState.fromJson(Map<String, dynamic> json) =>
  //     _$ActivityStateFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$ActivityStateToJson(this);

  ActivityState copyWith({
    ActivityStatus Function()? status,
    Activity? Function()? activity,
    List<Activity> Function()? activityList,
    Activity? Function()? lastDeletedActivity,
  }) {
    return ActivityState(
      status: status != null ? status() : this.status,
      activityList: activityList != null ? activityList() : this.activityList,
      activity: activity != null ? activity() : this.activity,
      lastDeletedActivity: lastDeletedActivity != null
          ? lastDeletedActivity()
          : this.lastDeletedActivity,
    );
  }

  @override
  List<Object?> get props =>
      [status, activity, activityList, lastDeletedActivity];
}
