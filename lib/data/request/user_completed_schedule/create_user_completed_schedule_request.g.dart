// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_completed_schedule_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserCompletedScheduleFixRequest
_$CreateUserCompletedScheduleFixRequestFromJson(Map<String, dynamic> json) =>
    CreateUserCompletedScheduleFixRequest(
      bookingId: (json['bookingId'] as num?)?.toInt(),
      countPeople: (json['countPeople'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateUserCompletedScheduleFixRequestToJson(
  CreateUserCompletedScheduleFixRequest instance,
) => <String, dynamic>{
  'bookingId': instance.bookingId,
  'countPeople': instance.countPeople,
};
