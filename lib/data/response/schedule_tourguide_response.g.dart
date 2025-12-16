// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_tourguide_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTourguideResponse _$ScheduleTourguideResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleTourguideResponse(
  schedule:
      json['schedule'] == null
          ? null
          : ScheduleTourGuideResponse.fromJson(
            json['schedule'] as Map<String, dynamic>,
          ),
  tour:
      json['tour'] == null
          ? null
          : TourResponse.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduleTourguideResponseToJson(
  ScheduleTourguideResponse instance,
) => <String, dynamic>{'schedule': instance.schedule, 'tour': instance.tour};

ScheduleTourGuideResponse _$ScheduleTourGuideResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleTourGuideResponse(
  id: (json['id'] as num?)?.toInt(),
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  maxSlot: (json['maxSlot'] as num?)?.toInt(),
  code: json['code'] as String?,
  tour:
      json['tour'] == null
          ? null
          : TourResponse.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduleTourGuideResponseToJson(
  ScheduleTourGuideResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'maxSlot': instance.maxSlot,
  'code': instance.code,
  'tour': instance.tour,
};

TourResponse _$TourResponseFromJson(Map<String, dynamic> json) => TourResponse(
  title: json['title'] as String?,
  tourImages: json['tourImages'] as List<dynamic>?,
);

Map<String, dynamic> _$TourResponseToJson(TourResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'tourImages': instance.tourImages,
    };
