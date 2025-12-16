// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_schedule_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddScheduleRequest _$AddScheduleRequestFromJson(Map<String, dynamic> json) =>
    AddScheduleRequest(
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

Map<String, dynamic> _$AddScheduleRequestToJson(AddScheduleRequest instance) =>
    <String, dynamic>{
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
