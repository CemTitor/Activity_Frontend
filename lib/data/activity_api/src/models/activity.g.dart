// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as String?,
      title: json['title'] as String?,
      date: json['date'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      city: json['city'] as String?,
      venue: json['venue'] as String?,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'description': instance.description,
      'category': instance.category,
      'city': instance.city,
      'venue': instance.venue,
    };
