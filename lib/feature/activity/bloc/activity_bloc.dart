import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:activity_frontend/data/activity_api/activity_api.dart';
import 'package:activity_frontend/domain/activity_repository/activity_repository.dart';

import 'package:bloc/bloc.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc({
    required ActivityRepository activityRepository,
  })  : _activityRepository = activityRepository,
        super(ActivityState()) {
    on<ActivitySubscriptionRequested>(onSubscriptionRequested);
    on<ActivityRemoved>(_onRemoveActivity);
    on<ActivityListFetched>(_onFetchActivityList);
  }
  final ActivityRepository _activityRepository;

  Future<void> onSubscriptionRequested(
    ActivitySubscriptionRequested event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(status: () => ActivityStatus.loading));

    await emit.forEach<List<Activity>>(
      _activityRepository.getActivityListasStream(),
      onData: (activityList) => state.copyWith(
        status: () => ActivityStatus.success,
        activityList: () => activityList,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ActivityStatus.failure,
      ),
    );
  }

  Future<void> _onRemoveActivity(
    ActivityRemoved event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(
      lastDeletedActivity: () => event.activity,

      ///I am giving activityList in here because If I dont, there is instant error in the UI
      activityList: () => state.activityList
          .where((activity) => activity.id != event.activity.id)
          .toList(),
    ));

    await _activityRepository.removeActivity(
        event.activity.id!, event.activity.title!);
  }

  Future<void> _onFetchActivityList(
    ActivityListFetched event,
    Emitter<ActivityState> emit,
  ) async {
    emit(state.copyWith(status: () => ActivityStatus.loading));

    try {
      final activityList = await _activityRepository.getActivityList();
      emit(state.copyWith(
        status: () => ActivityStatus.success,
        activityList: () => activityList,
      ));
    } catch (_) {
      emit(state.copyWith(status: () => ActivityStatus.failure));
    }
  }
}
