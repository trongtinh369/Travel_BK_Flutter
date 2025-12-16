// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffResponse _$StaffResponseFromJson(Map<String, dynamic> json) =>
    StaffResponse(
      userId: (json['userId'] as num?)?.toInt(),
      code: json['code'] as String?,
      isActive: json['isActive'] as bool?,
      cccd: json['cccd'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      startWorkingDate: json['startWorkingDate'] as String?,
      cccdIssueDate: json['cccdIssueDate'] as String?,
      cccD_front_path: json['cccD_front_path'] as String?,
      cccD_back_path: json['cccD_back_path'] as String?,
      endWorkingDate: json['endWorkingDate'] as String?,
      user:
          json['user'] == null
              ? null
              : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      role:
          json['role'] == null
              ? null
              : RoleResponse.fromJson(json['role'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StaffResponseToJson(StaffResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'code': instance.code,
      'isActive': instance.isActive,
      'cccd': instance.cccd,
      'address': instance.address,
      'dateOfBirth': instance.dateOfBirth,
      'startWorkingDate': instance.startWorkingDate,
      'cccdIssueDate': instance.cccdIssueDate,
      'cccD_front_path': instance.cccD_front_path,
      'cccD_back_path': instance.cccD_back_path,
      'endWorkingDate': instance.endWorkingDate,
      'user': instance.user,
      'role': instance.role,
    };
