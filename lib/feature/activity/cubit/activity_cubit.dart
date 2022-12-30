import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_frontend/data/activity_api/activity_api.dart';
import 'package:weather_frontend/domain/activity_repository/activity_repository.dart';

part 'activity_cubit.g.dart';
part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository _activityRepository;

  ActivityCubit(this._activityRepository) : super(ActivityState());

  // Future<void> onSubscriptionRequested() async {
  //   emit(state.copyWith(status: () => ActivityStatus.loading));
  //
  //   await emit.forEach<List<Activity>>(
  //     _activityRepository.getActivityList(),
  //     onData: (activityList) => state.copyWith(
  //       status: () => ActivityStatus.success,
  //       activityList: () => activityList,
  //     ),
  //     onError: (_, __) => state.copyWith(
  //       status: () => ActivityStatus.failure,
  //     ),
  //   );
  // }

  Future<void> fetchActivityList() async {
    emit(state.copyWith(status: ActivityStatus.loading));
    try {
      final activityList = await _activityRepository.getActivityList();

      emit(
        state.copyWith(
          status: ActivityStatus.success,
          activityList: activityList,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: ActivityStatus.failure));
    }
  }

  Future<void> removeActivity(String id) async {
    emit(state.copyWith(status: ActivityStatus.loading));
    try {
      await _activityRepository.removeActivity(id);

      emit(state.copyWith(
        lastDeletedActivity: state.activity,

        //todo: add activiyList attribute
      ));
    } on Exception {
      emit(state.copyWith(status: ActivityStatus.failure));
    }
  }

  @override
  ActivityState fromJson(Map<String, dynamic> json) =>
      ActivityState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ActivityState state) => state.toJson();
}
