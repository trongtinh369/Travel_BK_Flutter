// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_reception_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleReceptionResponse _$ScheduleReceptionResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleReceptionResponse(
  id: (json['id'] as num?)?.toInt(),
  code: json['code'] as String?,
  tour:
      json['tour'] == null
          ? null
          : TripResponse.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduleReceptionResponseToJson(
  ScheduleReceptionResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'tour': instance.tour,
};
