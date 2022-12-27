import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  String? id;
  String? title;
  String? date;
  String? description;
  String? category;
  String? city;
  String? venue;

  Activity(
      {this.id,
      this.title,
      this.date,
      this.description,
      this.category,
      this.city,
      this.venue});

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  List<Object?> get props => [
        id,
        title,
        date,
        description,
        category,
        city,
        venue,
      ];

  Activity copyWith({
    String? id,
    String? title,
    String? date,
    String? description,
    String? category,
    String? city,
    String? venue,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      category: category ?? this.category,
      city: city ?? this.city,
      venue: venue ?? this.venue,
    );
  }
}