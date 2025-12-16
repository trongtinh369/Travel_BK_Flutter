// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_activity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationActivityResponse _$LocationActivityResponseFromJson(
  Map<String, dynamic> json,
) => LocationActivityResponse(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  place:
      json['place'] == null
          ? null
          : PlaceResponse.fromJson(json['place'] as Map<String, dynamic>),
  activities:
      (json['activities'] as List<dynamic>?)
          ?.map((e) => ActivityResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$LocationActivityResponseToJson(
  LocationActivityResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'place': instance.place,
  'activities': instance.activities,
};

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
