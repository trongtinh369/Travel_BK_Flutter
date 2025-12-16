// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helpfull_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpfullResponse _$HelpfullResponseFromJson(Map<String, dynamic> json) =>
    HelpfullResponse(
      isEnable: json['isEnable'] as bool?,
      userId: (json['userId'] as num?)?.toInt(),
      reviewId: (json['reviewId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HelpfullResponseToJson(HelpfullResponse instance) =>
    <String, dynamic>{
      'isEnable': instance.isEnable,
      'userId': instance.userId,
      'reviewId': instance.reviewId,
    };
