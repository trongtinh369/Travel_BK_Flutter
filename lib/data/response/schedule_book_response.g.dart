// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleBookResponse _$ScheduleBookResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleBookResponse(
  id: (json['id'] as num?)?.toInt(),
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  maxSlot: (json['maxSlot'] as num?)?.toInt(),
  finalPrice: (json['finalPrice'] as num?)?.toInt(),
  tour:
      json['tour'] == null
          ? null
          : TourResponse.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduleBookResponseToJson(
  ScheduleBookResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'maxSlot': instance.maxSlot,
  'finalPrice': instance.finalPrice,
  'tour': instance.tour,
};

TourResponse _$TourResponseFromJson(Map<String, dynamic> json) => TourResponse(
  title: json['title'] as String?,
  percentDeposit: (json['percentDeposit'] as num?)?.toInt(),
  locations:
      (json['locations'] as List<dynamic>?)
          ?.map((e) => LocationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TourResponseToJson(TourResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'percentDeposit': instance.percentDeposit,
      'locations': instance.locations,
    };

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(name: json['name'] as String?);

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{'name': instance.name};
