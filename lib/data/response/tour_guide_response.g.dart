// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_guide_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourGuideResponse _$TourGuideResponseFromJson(Map<String, dynamic> json) =>
    TourGuideResponse(
      userId: (json['userId'] as num?)?.toInt(),
      code: json['code'] as String?,
      isActive: json['isActive'] as bool?,
      cccd: json['cccd'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      startWorkingDate: json['startWorkingDate'] as String?,
      cccdIssueDate: json['cccdIssueDate'] as String?,
      CCCD_front_path: json['CCCD_front_path'] as String?,
      CCCD_back_path: json['CCCD_back_path'] as String?,
      endWorkingDate: json['endWorkingDate'] as String?,
      ischecked: json['ischecked'] as bool?,
      user:
          json['user'] == null
              ? null
              : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TourGuideResponseToJson(TourGuideResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'code': instance.code,
      'isActive': instance.isActive,
      'cccd': instance.cccd,
      'address': instance.address,
      'dateOfBirth': instance.dateOfBirth,
      'startWorkingDate': instance.startWorkingDate,
      'cccdIssueDate': instance.cccdIssueDate,
      'CCCD_front_path': instance.CCCD_front_path,
      'CCCD_back_path': instance.CCCD_back_path,
      'endWorkingDate': instance.endWorkingDate,
      'ischecked': instance.ischecked,
      'user': instance.user,
    };
