// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fix_activity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixActivityRequest _$FixActivityRequestFromJson(Map<String, dynamic> json) =>
    FixActivityRequest(
      id: (json['id'] as num).toInt(),
      action: json['action'] as String,
    );

Map<String, dynamic> _$FixActivityRequestToJson(FixActivityRequest instance) =>
    <String, dynamic>{'id': instance.id, 'action': instance.action};
