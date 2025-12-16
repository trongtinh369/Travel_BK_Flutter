// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_schedule_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingScheduleRequest _$BookingScheduleRequestFromJson(
  Map<String, dynamic> json,
) => BookingScheduleRequest(
  scheduleId: (json['scheduleId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  numPeople: (json['numPeople'] as num).toInt(),
  email: json['email'] as String,
  phone: json['phone'] as String,
  totalPrice: (json['totalPrice'] as num).toInt(),
);

Map<String, dynamic> _$BookingScheduleRequestToJson(
  BookingScheduleRequest instance,
) => <String, dynamic>{
  'scheduleId': instance.scheduleId,
  'userId': instance.userId,
  'numPeople': instance.numPeople,
  'email': instance.email,
  'phone': instance.phone,
  'totalPrice': instance.totalPrice,
};
