// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideReviewsResponse _$GuideReviewsResponseFromJson(
  Map<String, dynamic> json,
) => GuideReviewsResponse(
  nameStaff: json['nameStaff'] as String?,
  schedule:
      json['schedule'] == null
          ? null
          : ScheduleAssignmentTourguideResponse.fromJson(
            json['schedule'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$GuideReviewsResponseToJson(
  GuideReviewsResponse instance,
) => <String, dynamic>{
  'nameStaff': instance.nameStaff,
  'schedule': instance.schedule,
};
