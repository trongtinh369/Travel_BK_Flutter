// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_staff_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStaffRequest _$UpdateStaffRequestFromJson(Map<String, dynamic> json) =>
    UpdateStaffRequest(
      userId: (json['userId'] as num).toInt(),
      code: json['code'] as String,
      isActive: json['isActive'] as bool,
      cccd: json['cccd'] as String,
      address: json['address'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      startWorkingDate: DateTime.parse(json['startWorkingDate'] as String),
      cccdIssueDate: DateTime.parse(json['cccdIssueDate'] as String),
      cccD_front_image: json['cccD_front_image'] as String,
      cccD_back_image: json['cccD_back_image'] as String,
      isRetainCCCDFront: json['isRetainCCCDFront'] as bool,
      isRetainCCCDBack: json['isRetainCCCDBack'] as bool,
      endWorkingDate: DateTime.parse(json['endWorkingDate'] as String),
      user: UserInStaffUpdateRequest.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UpdateStaffRequestToJson(UpdateStaffRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'code': instance.code,
      'isActive': instance.isActive,
      'cccd': instance.cccd,
      'address': instance.address,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'startWorkingDate': instance.startWorkingDate.toIso8601String(),
      'cccdIssueDate': instance.cccdIssueDate.toIso8601String(),
      'cccD_front_image': instance.cccD_front_image,
      'cccD_back_image': instance.cccD_back_image,
      'isRetainCCCDFront': instance.isRetainCCCDFront,
      'isRetainCCCDBack': instance.isRetainCCCDBack,
      'endWorkingDate': instance.endWorkingDate.toIso8601String(),
      'user': instance.user,
    };
