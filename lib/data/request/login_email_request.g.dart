// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEmailRequest _$LoginEmailRequestFromJson(Map<String, dynamic> json) =>
    LoginEmailRequest(
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginEmailRequestToJson(LoginEmailRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'token': instance.token,
    };
