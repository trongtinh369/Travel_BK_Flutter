// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_location_activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLocationActivities _$UpdateLocationActivitiesFromJson(
  Map<String, dynamic> json,
) => UpdateLocationActivities(
  id: (json['id'] as num).toInt(),
  placeId: (json['placeId'] as num).toInt(),
  name: json['name'] as String,
  activityIds:
      (json['activityIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$UpdateLocationActivitiesToJson(
  UpdateLocationActivities instance,
) => <String, dynamic>{
  'id': instance.id,
  'placeId': instance.placeId,
  'name': instance.name,
  'activityIds': instance.activityIds,
};
