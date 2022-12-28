// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityState _$ActivityStateFromJson(Map<String, dynamic> json) =>
    ActivityState(
      status: $enumDecodeNullable(_$ActivityStatusEnumMap, json['status']) ??
          ActivityStatus.initial,
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityStateToJson(ActivityState instance) =>
    <String, dynamic>{
      'status': _$ActivityStatusEnumMap[instance.status]!,
      'activity': instance.activity,
    };

const _$ActivityStatusEnumMap = {
  ActivityStatus.initial: 'initial',
  ActivityStatus.loading: 'loading',
  ActivityStatus.success: 'success',
  ActivityStatus.failure: 'failure',
};
