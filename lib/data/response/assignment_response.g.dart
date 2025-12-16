// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentResponse _$AssignmentResponseFromJson(
  Map<String, dynamic> json,
) => AssignmentResponse(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  tourImages:
      (json['tourImages'] as List<dynamic>?)?.map((e) => e as String).toList(),
  locations:
      (json['locations'] as List<dynamic>?)
          ?.map((e) => LocationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  places:
      (json['places'] as List<dynamic>?)
          ?.map(
            (e) => AssignmentPlaceResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$AssignmentResponseToJson(AssignmentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tourImages': instance.tourImages,
      'locations': instance.locations,
      'places': instance.places,
    };

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

AssignmentPlaceResponse _$AssignmentPlaceResponseFromJson(
  Map<String, dynamic> json,
) => AssignmentPlaceResponse(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  location:
      json['location'] == null
          ? null
          : LocationResponse.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AssignmentPlaceResponseToJson(
  AssignmentPlaceResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'location': instance.location,
};
