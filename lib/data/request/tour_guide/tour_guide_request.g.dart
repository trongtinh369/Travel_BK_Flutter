// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_guide_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourGuideRequest _$TourGuideRequestFromJson(Map<String, dynamic> json) =>
    TourGuideRequest(
      userId: (json['userId'] as num?)?.toInt(),
      ischecked: json['ischecked'] as bool?,
    );

Map<String, dynamic> _$TourGuideRequestToJson(TourGuideRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'ischecked': instance.ischecked,
    };
