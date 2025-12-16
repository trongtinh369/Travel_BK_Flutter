// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_of_tour_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayOfTourResponse _$DayOfTourResponseFromJson(Map<String, dynamic> json) =>
    DayOfTourResponse(
      title: json['title'] as String?,
      description: json['description'] as String?,
      dayActivities:
          (json['dayActivities'] as List<dynamic>?)
              ?.map(
                (e) => DayActivityResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$DayOfTourResponseToJson(DayOfTourResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'dayActivities': instance.dayActivities,
    };
