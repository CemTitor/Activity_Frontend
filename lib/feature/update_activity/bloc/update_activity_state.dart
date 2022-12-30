part of 'update_activity_bloc.dart';

enum UpdateActivityStatus { initial, loading, success, failure }

extension UpdateActivityStatusX on UpdateActivityStatus {
  bool get isLoadingOrSuccess => [
        UpdateActivityStatus.loading,
        UpdateActivityStatus.success,
      ].contains(this);
}

class UpdateActivityState extends Equatable {
  const UpdateActivityState({
    this.status = UpdateActivityStatus.initial,
    this.initialActivity,
    this.id = '',
    this.title = '',
    this.description = '',
    this.category = '',
    this.city = '',
    this.venue = '',
  });

  final UpdateActivityStatus status;
  final Activity? initialActivity;
  final String id;
  final String title;
  final String description;
  final String category;
  final String city;
  final String venue;

  bool get isNewActivity => initialActivity == null;

  UpdateActivityState copyWith({
    UpdateActivityStatus? status,
    Activity? initialActivity,
    String? id,
    String? title,
    String? description,
    String? category,
    String? city,
    String? venue,
  }) {
    return UpdateActivityState(
      status: status ?? this.status,
      initialActivity: initialActivity ?? this.initialActivity,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      city: city ?? this.city,
      venue: venue ?? this.venue,
    );
  }

  @override
  List<Object?> get props => [
        status,
        initialActivity,
        id,
        title,
        description,
        category,
        city,
        venue,
      ];
}
