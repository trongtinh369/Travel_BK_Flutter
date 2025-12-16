// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_completed_schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCompletedScheduleFixResponse _$UserCompletedScheduleFixResponseFromJson(
  Map<String, dynamic> json,
) => UserCompletedScheduleFixResponse(
  countPeople: (json['countPeople'] as num?)?.toInt(),
  booking:
      json['booking'] == null
          ? null
          : BookingResponse.fromJson(json['booking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserCompletedScheduleFixResponseToJson(
  UserCompletedScheduleFixResponse instance,
) => <String, dynamic>{
  'countPeople': instance.countPeople,
  'booking': instance.booking,
};
