// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  id: (json['id'] as num?)?.toInt(),
  roleId: (json['roleId'] as num?)?.toInt(),
  money: (json['money'] as num?)?.toInt(),
  bankNumber: json['bankNumber'] as String?,
  bank: json['bank'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  avatarPath: json['avatarPath'] as String?,
  bankBranch: json['bankBranch'] as String?,
  refundStatus: json['refundStatus'] as bool?,
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roleId': instance.roleId,
      'money': instance.money,
      'bankNumber': instance.bankNumber,
      'bank': instance.bank,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'avatarPath': instance.avatarPath,
      'bankBranch': instance.bankBranch,
      'refundStatus': instance.refundStatus,
    };
