// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_status_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStatusBookingRequest _$UpdateStatusBookingRequestFromJson(
  Map<String, dynamic> json,
) => UpdateStatusBookingRequest(
  id: (json['id'] as num).toInt(),
  statusId: (json['statusId'] as num).toInt(),
);

Map<String, dynamic> _$UpdateStatusBookingRequestToJson(
  UpdateStatusBookingRequest instance,
) => <String, dynamic>{'id': instance.id, 'statusId': instance.statusId};
