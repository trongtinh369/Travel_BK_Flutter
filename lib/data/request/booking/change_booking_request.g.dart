// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeBookingRequest _$ChangeBookingRequestFromJson(
  Map<String, dynamic> json,
) => ChangeBookingRequest(
  scheduleId: (json['scheduleId'] as num).toInt(),
  bookingId: (json['bookingId'] as num).toInt(),
);

Map<String, dynamic> _$ChangeBookingRequestToJson(
  ChangeBookingRequest instance,
) => <String, dynamic>{
  'scheduleId': instance.scheduleId,
  'bookingId': instance.bookingId,
};
