// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_assignment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourAssignmentResponse _$TourAssignmentResponseFromJson(
  Map<String, dynamic> json,
) => TourAssignmentResponse(
  title: json['title'] as String?,
  price: (json['price'] as num?)?.toInt(),
  locations:
      (json['locations'] as List<dynamic>?)
          ?.map((e) => LocationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  tourImages:
      (json['tourImages'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$TourAssignmentResponseToJson(
  TourAssignmentResponse instance,
) => <String, dynamic>{
  'title': instance.title,
  'price': instance.price,
  'locations': instance.locations,
  'tourImages': instance.tourImages,
};

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(name: json['name'] as String?);

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{'name': instance.name};
