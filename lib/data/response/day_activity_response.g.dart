// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_activity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayActivityResponse _$DayActivityResponseFromJson(Map<String, dynamic> json) =>
    DayActivityResponse(
      activity:
          json['activity'] == null
              ? null
              : ActivityResponseData.fromJson(
                json['activity'] as Map<String, dynamic>,
              ),
      locationActivity:
          json['locationActivity'] == null
              ? null
              : LocationActivityResponse.fromJson(
                json['locationActivity'] as Map<String, dynamic>,
              ),
      time: json['time'] as String?,
    );

Map<String, dynamic> _$DayActivityResponseToJson(
  DayActivityResponse instance,
) => <String, dynamic>{
  'activity': instance.activity,
  'locationActivity': instance.locationActivity,
  'time': instance.time,
};
