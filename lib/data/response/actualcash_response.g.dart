// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actualcash_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActualcashResponse _$ActualcashResponseFromJson(Map<String, dynamic> json) =>
    ActualcashResponse(
      id: (json['id'] as num?)?.toInt(),
      money: (json['money'] as num?)?.toInt(),
      bookingId: (json['bookingId'] as num?)?.toInt(),
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ActualcashResponseToJson(ActualcashResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'money': instance.money,
      'bookingId': instance.bookingId,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
