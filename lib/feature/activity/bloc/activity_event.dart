part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

///This is the startup event. In response, the bloc subscribes to the stream of todos from the TodosRepository.
class ActivitySubscriptionRequested extends ActivityEvent {
  const ActivitySubscriptionRequested();
}

///This deletes a Activity
class ActivityRemoved extends ActivityEvent {
  const ActivityRemoved(this.activity);

  final Activity activity;

  @override
  List<Object> get props => [activity];
}

///This fetches a list of Activitys
class ActivityListFetched extends ActivityEvent {
  const ActivityListFetched();
}
