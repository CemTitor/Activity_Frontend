// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityState _$ActivityStateFromJson(Map<String, dynamic> json) =>
    ActivityState(
      status: $enumDecodeNullable(_$ActivityStatusEnumMap, json['status']) ??
          ActivityStatus.initial,
      activityList: (json['activityList'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Activity>[],
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      lastDeletedActivity: json['lastDeletedActivity'] == null
          ? null
          : Activity.fromJson(
              json['lastDeletedActivity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityStateToJson(ActivityState instance) =>
    <String, dynamic>{
      'status': _$ActivityStatusEnumMap[instance.status]!,
      'activity': instance.activity,
      'activityList': instance.activityList,
      'lastDeletedActivity': instance.lastDeletedActivity,
    };

const _$ActivityStatusEnumMap = {
  ActivityStatus.initial: 'initial',
  ActivityStatus.loading: 'loading',
  ActivityStatus.success: 'success',
  ActivityStatus.failure: 'failure',
};
