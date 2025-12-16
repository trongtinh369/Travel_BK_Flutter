// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_location_activity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLocationActivityRequest _$AddLocationActivityRequestFromJson(
  Map<String, dynamic> json,
) => AddLocationActivityRequest(
  placeId: (json['placeId'] as num).toInt(),
  name: json['name'] as String,
  activityIds:
      (json['activityIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$AddLocationActivityRequestToJson(
  AddLocationActivityRequest instance,
) => <String, dynamic>{
  'placeId': instance.placeId,
  'name': instance.name,
  'activityIds': instance.activityIds,
};
