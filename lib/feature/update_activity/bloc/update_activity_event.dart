part of 'update_activity_bloc.dart';

abstract class UpdateActivityEvent extends Equatable {
  const UpdateActivityEvent();

  @override
  List<Object> get props => [];
}

class UpdateActivityTitleChanged extends UpdateActivityEvent {
  const UpdateActivityTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class UpdateActivityDescriptionChanged extends UpdateActivityEvent {
  const UpdateActivityDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class UpdateActivityCategoryChanged extends UpdateActivityEvent {
  const UpdateActivityCategoryChanged(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

class UpdateActivityCityChanged extends UpdateActivityEvent {
  const UpdateActivityCityChanged(this.city);

  final String city;

  @override
  List<Object> get props => [city];
}

class UpdateActivityVenueChanged extends UpdateActivityEvent {
  const UpdateActivityVenueChanged(this.venue);

  final String venue;

  @override
  List<Object> get props => [venue];
}

class UpdateActivitySubmitted extends UpdateActivityEvent {
  const UpdateActivitySubmitted();
}
