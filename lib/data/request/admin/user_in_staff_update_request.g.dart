// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_in_staff_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInStaffUpdateRequest _$UserInStaffUpdateRequestFromJson(
  Map<String, dynamic> json,
) => UserInStaffUpdateRequest(
  id: (json['id'] as num).toInt(),
  roleId: (json['roleId'] as num).toInt(),
  money: (json['money'] as num).toInt(),
  bankNumber: json['bankNumber'] as String,
  bank: json['bank'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  bankBranch: json['bankBranch'] as String,
  avatarPath: json['avatarPath'] as String,
  refundStatus: json['refundStatus'] as bool,
);

Map<String, dynamic> _$UserInStaffUpdateRequestToJson(
  UserInStaffUpdateRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'roleId': instance.roleId,
  'money': instance.money,
  'bankNumber': instance.bankNumber,
  'bank': instance.bank,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'bankBranch': instance.bankBranch,
  'avatarPath': instance.avatarPath,
  'refundStatus': instance.refundStatus,
};
