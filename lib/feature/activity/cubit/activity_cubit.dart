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

  Future<void> fetchActivity() async {
    // if (city == null || city.isEmpty) return;

    emit(state.copyWith(status: ActivityStatus.loading));

    try {
      // final activity = Activity.fromRepository(
      //   await _activityRepository.getActivity(),
      // );

      final activity = await _activityRepository.getActivity();

      emit(
        state.copyWith(
          status: ActivityStatus.success,
          // degreeUnits: units,
          activity: activity.copyWith(),
          // weather: weather.copyWith(degree: Degree(value: value)),
        ),
      );
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
