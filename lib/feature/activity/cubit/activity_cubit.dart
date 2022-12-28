import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_frontend/data/activity_api/activity_api.dart';
import 'package:weather_frontend/data/weather_api/collectapi_weather.dart';
import 'package:weather_frontend/domain/activity_repository/activity_repository.dart';

part 'activity_cubit.g.dart';
part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository _activityRepository;

  ActivityCubit(this._activityRepository) : super(ActivityState());

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
  //
  // Future<void> addActivity() async {
  //   emit(state.copyWith(status: ActivityStatus.loading));
  //   try {
  //     final activityList = await _activityRepository.addActivity();
  //
  //     emit(
  //       state.copyWith(
  //         status: ActivityStatus.success,
  //         activityList: activityList,
  //       ),
  //     );
  //   } on Exception {
  //     emit(state.copyWith(status: ActivityStatus.failure));
  //   }
  // }
  //
  // Future<void> removeActivity(int id) async {
  //   emit(state.copyWith(status: ActivityStatus.loading));
  //   try {
  //     final activity = await _activityRepository.removeActivity(id);
  //
  //     emit(
  //       state.copyWith(
  //         status: ActivityStatus.success,
  //     );
  //   } on Exception {
  //     emit(state.copyWith(status: ActivityStatus.failure));
  //   }
  // }
  //
  // Future<void> updateActivity() async {
  //   emit(state.copyWith(status: ActivityStatus.loading));
  //   try {
  //     final activityList = await _activityRepository.updateActivity();
  //
  //     emit(
  //       state.copyWith(
  //         status: ActivityStatus.success,
  //         activityList: activityList,
  //       ),
  //     );
  //   } on Exception {
  //     emit(state.copyWith(status: ActivityStatus.failure));
  //   }
  // }

  @override
  ActivityState fromJson(Map<String, dynamic> json) =>
      ActivityState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ActivityState state) => state.toJson();
}
