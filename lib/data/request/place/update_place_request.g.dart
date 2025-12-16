// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_place_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePlaceRequestData _$UpdatePlaceRequestDataFromJson(
  Map<String, dynamic> json,
) => UpdatePlaceRequestData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  location:
      json['location'] == null
          ? null
          : ProvinceResponse.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdatePlaceRequestDataToJson(
  UpdatePlaceRequestData instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'location': instance.location?.toJson(),
};
