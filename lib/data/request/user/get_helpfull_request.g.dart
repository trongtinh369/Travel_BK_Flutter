// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_helpfull_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHelpFullRequest _$GetHelpFullRequestFromJson(Map<String, dynamic> json) =>
    GetHelpFullRequest(
      userId: (json['userId'] as num).toInt(),
      reviewId: (json['reviewId'] as num).toInt(),
    );

Map<String, dynamic> _$GetHelpFullRequestToJson(GetHelpFullRequest instance) =>
    <String, dynamic>{'userId': instance.userId, 'reviewId': instance.reviewId};
