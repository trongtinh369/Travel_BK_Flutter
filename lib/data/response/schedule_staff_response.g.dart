// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_staff_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleStaffResponse _$ScheduleStaffResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleStaffResponse(
  totalReviews: (json['totalReviews'] as num).toInt(),
  totalStars: (json['totalStars'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  tourId: (json['tourId'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  openDate: DateTime.parse(json['openDate'] as String),
  bookedSlot: (json['bookedSlot'] as num).toInt(),
  maxSlot: (json['maxSlot'] as num).toInt(),
  finalPrice: (json['finalPrice'] as num).toInt(),
  gatheringTime: json['gatheringTime'] as String,
  code: json['code'] as String,
  desposit: (json['desposit'] as num).toInt(),
  tour: TripManagerResponse.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduleStaffResponseToJson(
  ScheduleStaffResponse instance,
) => <String, dynamic>{
  'totalReviews': instance.totalReviews,
  'totalStars': instance.totalStars,
  'id': instance.id,
  'tourId': instance.tourId,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'openDate': instance.openDate.toIso8601String(),
  'bookedSlot': instance.bookedSlot,
  'maxSlot': instance.maxSlot,
  'finalPrice': instance.finalPrice,
  'gatheringTime': instance.gatheringTime,
  'code': instance.code,
  'desposit': instance.desposit,
  'tour': instance.tour,
};
