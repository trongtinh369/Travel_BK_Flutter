// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_schedule_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateScheduleRequest _$UpdateScheduleRequestFromJson(
  Map<String, dynamic> json,
) => UpdateScheduleRequest(
  id: (json['id'] as num).toInt(),
  tourId: (json['tourId'] as num).toInt(),
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  openDate: json['openDate'] as String,
  maxSlot: (json['maxSlot'] as num).toInt(),
  finalPrice: (json['finalPrice'] as num).toInt(),
  gatheringTime: json['gatheringTime'] as String,
  code: json['code'] as String,
  desposit: (json['desposit'] as num).toInt(),
);

Map<String, dynamic> _$UpdateScheduleRequestToJson(
  UpdateScheduleRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'tourId': instance.tourId,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'openDate': instance.openDate,
  'maxSlot': instance.maxSlot,
  'finalPrice': instance.finalPrice,
  'gatheringTime': instance.gatheringTime,
  'code': instance.code,
  'desposit': instance.desposit,
};
