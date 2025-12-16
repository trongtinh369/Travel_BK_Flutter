// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_reviews_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReviewsRequest _$GetReviewsRequestFromJson(Map<String, dynamic> json) =>
    GetReviewsRequest(
      userId: (json['userId'] as num).toInt(),
      tourId: (json['tourId'] as num).toInt(),
    );

Map<String, dynamic> _$GetReviewsRequestToJson(GetReviewsRequest instance) =>
    <String, dynamic>{'userId': instance.userId, 'tourId': instance.tourId};
