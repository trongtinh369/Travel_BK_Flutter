// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_user_completed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleUserCompletedResponse _$ScheduleUserCompletedResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleUserCompletedResponse(
  id: (json['id'] as num?)?.toInt(),
  finalPrice: (json['finalPrice'] as num?)?.toInt(),
  code: json['code'] as String?,
  tour:
      json['tour'] == null
          ? null
          : TripManagerResponse.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduleUserCompletedResponseToJson(
  ScheduleUserCompletedResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'finalPrice': instance.finalPrice,
  'code': instance.code,
  'tour': instance.tour,
};
