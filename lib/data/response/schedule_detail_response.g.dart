// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDetailResponse _$ScheduleDetailResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleDetailResponse(
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  maxSlot: (json['maxSlot'] as num?)?.toInt(),
  tour:
      json['tour'] == null
          ? null
          : TourResponse.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScheduleDetailResponseToJson(
  ScheduleDetailResponse instance,
) => <String, dynamic>{
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'maxSlot': instance.maxSlot,
  'tour': instance.tour,
};

TourResponse _$TourResponseFromJson(Map<String, dynamic> json) => TourResponse(
  day: (json['day'] as num?)?.toInt(),
  title: json['title'] as String?,
  dayOfTours:
      (json['dayOfTours'] as List<dynamic>?)
          ?.map((e) => DayOfTourResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TourResponseToJson(TourResponse instance) =>
    <String, dynamic>{
      'day': instance.day,
      'title': instance.title,
      'dayOfTours': instance.dayOfTours,
    };

DayOfTourResponse _$DayOfTourResponseFromJson(Map<String, dynamic> json) =>
    DayOfTourResponse(
      title: json['title'] as String?,
      description: json['description'] as String?,
      dayActivities:
          (json['dayActivities'] as List<dynamic>?)
              ?.map(
                (e) => DayActivitieResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$DayOfTourResponseToJson(DayOfTourResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'dayActivities': instance.dayActivities,
    };

DayActivitieResponse _$DayActivitieResponseFromJson(
  Map<String, dynamic> json,
) => DayActivitieResponse(
  activity:
      json['activity'] == null
          ? null
          : ActivityResponse.fromJson(json['activity'] as Map<String, dynamic>),
  locationActivity:
      json['locationActivity'] == null
          ? null
          : LocationActivityResponse.fromJson(
            json['locationActivity'] as Map<String, dynamic>,
          ),
  time: json['time'] as String?,
);

Map<String, dynamic> _$DayActivitieResponseToJson(
  DayActivitieResponse instance,
) => <String, dynamic>{
  'activity': instance.activity,
  'locationActivity': instance.locationActivity,
  'time': instance.time,
};

ActivityResponse _$ActivityResponseFromJson(Map<String, dynamic> json) =>
    ActivityResponse(action: json['action'] as String?);

Map<String, dynamic> _$ActivityResponseToJson(ActivityResponse instance) =>
    <String, dynamic>{'action': instance.action};

LocationActivityResponse _$LocationActivityResponseFromJson(
  Map<String, dynamic> json,
) => LocationActivityResponse(name: json['name'] as String?);

Map<String, dynamic> _$LocationActivityResponseToJson(
  LocationActivityResponse instance,
) => <String, dynamic>{'name': instance.name};
