// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityResponseData _$ActivityResponseDataFromJson(
  Map<String, dynamic> json,
) => ActivityResponseData(
  id: (json['id'] as num?)?.toInt(),
  action: json['action'] as String?,
);

Map<String, dynamic> _$ActivityResponseDataToJson(
  ActivityResponseData instance,
) => <String, dynamic>{'id': instance.id, 'action': instance.action};
