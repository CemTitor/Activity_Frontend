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
            category: initialActivity?.category ?? '',
            city: initialActivity?.city ?? '',
            venue: initialActivity?.venue ?? '',
            id: initialActivity?.id ?? '',
          ),
        ) {
    on<UpdateActivityTitleChanged>(_onTitleChanged);
    on<UpdateActivityDescriptionChanged>(_onDescriptionChanged);
    on<UpdateActivityCategoryChanged>(_onCategoryChanged);
    on<UpdateActivitySubmitted>(_onActivitySubmitted);
    on<UpdateActivityCityChanged>(_onCityChanged);
    on<UpdateActivityVenueChanged>(_onVenueChanged);
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

  void _onCategoryChanged(
    UpdateActivityCategoryChanged event,
    Emitter<UpdateActivityState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  void _onCityChanged(
    UpdateActivityCityChanged event,
    Emitter<UpdateActivityState> emit,
  ) {
    emit(state.copyWith(city: event.city));
  }

  void _onVenueChanged(
    UpdateActivityVenueChanged event,
    Emitter<UpdateActivityState> emit,
  ) {
    emit(state.copyWith(venue: event.venue));
  }

  Future<void> _onActivitySubmitted(
    UpdateActivitySubmitted event,
    Emitter<UpdateActivityState> emit,
  ) async {
    emit(state.copyWith(status: UpdateActivityStatus.loading));
    final activity = (state.initialActivity ?? Activity(title: '')).copyWith(
      id: state.id,
      title: state.title,
      description: state.description,
      category: state.category,
      city: state.city,
      venue: state.venue,
    );

    try {
      state.isNewActivity
          ? await _activityRepository.addActivity(activity)
          : await _activityRepository.updateActivity(activity);

      emit(
        state.copyWith(
          status: UpdateActivityStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: UpdateActivityStatus.failure));
    }
  }
}
