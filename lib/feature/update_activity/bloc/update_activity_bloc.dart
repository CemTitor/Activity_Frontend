import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_frontend/data/activity_api/src/models/activity.dart';
import 'package:weather_frontend/domain/activity_repository/activity_repository.dart';

part 'update_activity_event.dart';
part 'update_activity_state.dart';

///UpdateActivityBloc depends on the ActivitysRepository, just like ActivitysOverviewBloc and StatsBloc.
///Unlike the other Blocs, UpdateActivityBloc DOES NOT subscribe to _activitysRepository.getActivitys. It is a "write-only" bloc meaning it DOESN'T NEED TO read any information from the repository.
class UpdateActivityBloc
    extends Bloc<UpdateActivityEvent, UpdateActivityState> {
  UpdateActivityBloc({
    required ActivityRepository activityRepository,
    required Activity? initialActivity,
  })  : _activityRepository = activityRepository,
        super(
          UpdateActivityState(
            initialActivity: initialActivity,
            title: initialActivity?.title ?? '',
            description: initialActivity?.description ?? '',
          ),
        ) {
    on<UpdateActivityTitleChanged>(_onTitleChanged);
    on<UpdateActivityDescriptionChanged>(_onDescriptionChanged);
    on<UpdateActivitySubmitted>(_onActivitySubmitted);
  }

  final ActivityRepository _activityRepository;

  void _onTitleChanged(
    UpdateActivityTitleChanged event,
    Emitter<UpdateActivityState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    UpdateActivityDescriptionChanged event,
    Emitter<UpdateActivityState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onActivitySubmitted(
    UpdateActivitySubmitted event,
    Emitter<UpdateActivityState> emit,
  ) async {
    emit(state.copyWith(status: UpdateActivityStatus.loading));
    final activity = (state.initialActivity ?? Activity(title: '')).copyWith(
      id: Random().nextInt(1000).toString(),
      title: state.title,
      description: state.description,
      date: "2022-12-29T13:52:00.593Z",
      category: state.category,
      city: state.city,
      venue: state.venue,
    );

    try {
      state.isNewActivity
          ? await _activityRepository.addActivity(activity)
          : await _activityRepository.updateActivity(activity);

      // await _activityRepository.addActivity(activity);

      emit(state.copyWith(status: UpdateActivityStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UpdateActivityStatus.failure));
    }
  }
}
