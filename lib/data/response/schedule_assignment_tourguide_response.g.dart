// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_assignment_tourguide_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleAssignmentTourguideResponse
_$ScheduleAssignmentTourguideResponseFromJson(Map<String, dynamic> json) =>
    ScheduleAssignmentTourguideResponse(
      id: (json['id'] as num?)?.toInt(),
      tourId: (json['tourId'] as num?)?.toInt(),
      startDate:
          json['startDate'] == null
              ? null
              : DateTime.parse(json['startDate'] as String),
      endDate:
          json['endDate'] == null
              ? null
              : DateTime.parse(json['endDate'] as String),
      code: json['code'] as String?,
      maxSlot: (json['maxSlot'] as num?)?.toInt(),
      tour:
          json['tour'] == null
              ? null
              : TourResponse.fromJson(json['tour'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleAssignmentTourguideResponseToJson(
  ScheduleAssignmentTourguideResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'tourId': instance.tourId,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'maxSlot': instance.maxSlot,
  'code': instance.code,
  'tour': instance.tour,
};

TourResponse _$TourResponseFromJson(Map<String, dynamic> json) => TourResponse(
  title: json['title'] as String?,
  locations:
      (json['locations'] as List<dynamic>?)
          ?.map((e) => LocationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  description: json['description'] as String?,
);

Map<String, dynamic> _$TourResponseToJson(TourResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'locations': instance.locations,
    };

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(name: json['name'] as String?);

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{'name': instance.name};
