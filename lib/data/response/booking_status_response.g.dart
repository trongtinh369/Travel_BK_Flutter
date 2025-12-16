// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingStatusResponse _$BookingStatusResponseFromJson(
  Map<String, dynamic> json,
) => BookingStatusResponse(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$BookingStatusResponseToJson(
  BookingStatusResponse instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
