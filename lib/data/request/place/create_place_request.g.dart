// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_place_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePlaceRequestData _$CreatePlaceRequestDataFromJson(
  Map<String, dynamic> json,
) => CreatePlaceRequestData(
  name: json['name'] as String?,
  location:
      json['location'] == null
          ? null
          : ProvinceResponse.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreatePlaceRequestDataToJson(
  CreatePlaceRequestData instance,
) => <String, dynamic>{
  'name': instance.name,
  'location': instance.location?.toJson(),
};
