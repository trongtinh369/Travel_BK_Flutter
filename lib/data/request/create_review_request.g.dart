// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReviewRequest _$CreateReviewRequestFromJson(Map<String, dynamic> json) =>
    CreateReviewRequest(
      userId: (json['userId'] as num).toInt(),
      scheduleId: (json['scheduleId'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
      content: json['content'] as String,
    );

Map<String, dynamic> _$CreateReviewRequestToJson(
  CreateReviewRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'scheduleId': instance.scheduleId,
  'rating': instance.rating,
  'content': instance.content,
};
