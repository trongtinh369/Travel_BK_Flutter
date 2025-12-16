// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
  roleId: (json['roleId'] as num).toInt(),
  password: json['password'] as String,
  money: (json['money'] as num).toInt(),
  bankNumber: json['bankNumber'] as String,
  bank: json['bank'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  avatarPath: json['avatarPath'] as String,
  bankBranch: json['bankBranch'] as String,
  token: json['token'] as String,
);

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'password': instance.password,
      'money': instance.money,
      'bankNumber': instance.bankNumber,
      'bank': instance.bank,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'avatarPath': instance.avatarPath,
      'bankBranch': instance.bankBranch,
      'token': instance.token,
    };
