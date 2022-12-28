part of 'activity_cubit.dart';

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

  ActivityState({
    this.status = ActivityStatus.initial,
    this.activityList = const <Activity>[],
    Activity? activity,
  }) : activity = activity ?? Activity.empty;

  factory ActivityState.fromJson(Map<String, dynamic> json) =>
      _$ActivityStateFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityStateToJson(this);

  ActivityState copyWith({
    ActivityStatus? status,
    Activity? activity,
    List<Activity>? activityList,
  }) {
    return ActivityState(
      status: status ?? this.status,
      activity: activity ?? this.activity,
      activityList: activityList ?? this.activityList,
    );
  }

  @override
  List<Object?> get props => [status, activity, activityList];
}
