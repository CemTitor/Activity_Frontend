// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherState _$WeatherStateFromJson(Map<String, dynamic> json) => WeatherState(
      status: $enumDecodeNullable(_$WeatherStatusEnumMap, json['status']) ??
          WeatherStatus.initial,
      degreeUnits:
          $enumDecodeNullable(_$DegreeUnitsEnumMap, json['degreeUnits']) ??
              DegreeUnits.celsius,
      weather: json['weather'] == null
          ? null
          : Weather.fromJson(json['weather'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherStateToJson(WeatherState instance) =>
    <String, dynamic>{
      'status': _$WeatherStatusEnumMap[instance.status]!,
      'weather': instance.weather,
      'degreeUnits': _$DegreeUnitsEnumMap[instance.degreeUnits]!,
    };

const _$WeatherStatusEnumMap = {
  WeatherStatus.initial: 'initial',
  WeatherStatus.loading: 'loading',
  WeatherStatus.success: 'success',
  WeatherStatus.failure: 'failure',
};

const _$DegreeUnitsEnumMap = {
  DegreeUnits.fahrenheit: 'fahrenheit',
  DegreeUnits.celsius: 'celsius',
};
