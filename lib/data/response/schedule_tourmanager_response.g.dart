// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_tourmanager_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTourmanagerResponse _$ScheduleTourmanagerResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleTourmanagerResponse(
  id: (json['id'] as num?)?.toInt(),
  tourId: (json['tourId'] as num?)?.toInt(),
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  openDate: json['openDate'] as String?,
  bookedSlot: (json['bookedSlot'] as num?)?.toInt(),
  maxSlot: (json['maxSlot'] as num?)?.toInt(),
  finalPrice: (json['finalPrice'] as num?)?.toInt(),
  gatheringTime: json['gatheringTime'] as String?,
  code: json['code'] as String?,
  desposit: (json['desposit'] as num?)?.toInt(),
  tour:
      json['tour'] == null
          ? null
          : TripResponse.fromJson(json['tour'] as Map<String, dynamic>),
  processingBooking: (json['processingBooking'] as num?)?.toInt(),
  depositBooking: (json['depositBooking'] as num?)?.toInt(),
  paidBooking: (json['paidBooking'] as num?)?.toInt(),
);

Map<String, dynamic> _$ScheduleTourmanagerResponseToJson(
  ScheduleTourmanagerResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'tourId': instance.tourId,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'openDate': instance.openDate,
  'bookedSlot': instance.bookedSlot,
  'maxSlot': instance.maxSlot,
  'finalPrice': instance.finalPrice,
  'gatheringTime': instance.gatheringTime,
  'code': instance.code,
  'desposit': instance.desposit,
  'tour': instance.tour,
  'processingBooking': instance.processingBooking,
  'depositBooking': instance.depositBooking,
  'paidBooking': instance.paidBooking,
};

TripResponse _$TripResponseFromJson(Map<String, dynamic> json) => TripResponse(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  price: (json['price'] as num?)?.toInt(),
  description: json['description'] as String?,
  tourImages: json['tourImages'] as List<dynamic>?,
  locations:
      (json['locations'] as List<dynamic>?)
          ?.map((e) => ProvinceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  places:
      (json['places'] as List<dynamic>?)
          ?.map((e) => PlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TripResponseToJson(TripResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'tourImages': instance.tourImages,
      'locations': instance.locations,
      'places': instance.places,
    };

ProvinceResponse _$ProvinceResponseFromJson(Map<String, dynamic> json) =>
    ProvinceResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProvinceResponseToJson(ProvinceResponse instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
