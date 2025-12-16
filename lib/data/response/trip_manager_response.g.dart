// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_manager_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripManagerResponse _$TripManagerResponseFromJson(
  Map<String, dynamic> json,
) => TripManagerResponse(
  id: (json['id'] as num?)?.toInt(),
  day: (json['day'] as num?)?.toInt(),
  title: json['title'] as String?,
  price: (json['price'] as num?)?.toInt(),
  percentDeposit: (json['percentDeposit'] as num?)?.toInt(),
  description: json['description'] as String?,
  tourImages:
      (json['tourImages'] as List<dynamic>?)?.map((e) => e as String).toList(),
  locations:
      (json['locations'] as List<dynamic>?)
          ?.map((e) => ProvinceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  dayOfTours:
      (json['dayOfTours'] as List<dynamic>?)
          ?.map((e) => DayOfTourResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  totalReviews: (json['totalReviews'] as num?)?.toInt(),
  totalStars: (json['totalStars'] as num?)?.toInt(),
  places:
      (json['places'] as List<dynamic>?)
          ?.map((e) => PlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TripManagerResponseToJson(
  TripManagerResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'day': instance.day,
  'title': instance.title,
  'price': instance.price,
  'percentDeposit': instance.percentDeposit,
  'description': instance.description,
  'tourImages': instance.tourImages,
  'locations': instance.locations,
  'dayOfTours': instance.dayOfTours,
  'totalReviews': instance.totalReviews,
  'totalStars': instance.totalStars,
  'places': instance.places,
};
