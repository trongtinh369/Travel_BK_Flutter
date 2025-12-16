// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActualcashData _$ActualcashDataFromJson(Map<String, dynamic> json) =>
    ActualcashData(
      id: (json['id'] as num?)?.toInt(),
      money: (json['money'] as num?)?.toInt(),
      bookingId: (json['bookingId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ActualcashDataToJson(ActualcashData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'money': instance.money,
      'bookingId': instance.bookingId,
      'createdAt': instance.createdAt,
    };

UserCompletedScheduleResponse _$UserCompletedScheduleResponseFromJson(
  Map<String, dynamic> json,
) => UserCompletedScheduleResponse(
  countPeople: (json['countPeople'] as num?)?.toInt(),
  actualcashs:
      json['actualcashs'] == null
          ? null
          : ActualcashData.fromJson(
            json['actualcashs'] as Map<String, dynamic>,
          ),
  booking:
      json['booking'] == null
          ? null
          : BookingResponse.fromJson(json['booking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserCompletedScheduleResponseToJson(
  UserCompletedScheduleResponse instance,
) => <String, dynamic>{
  'countPeople': instance.countPeople,
  'actualcashs': instance.actualcashs,
  'booking': instance.booking,
};
