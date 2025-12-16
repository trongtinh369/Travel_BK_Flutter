// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteResponse _$FavoriteResponseFromJson(Map<String, dynamic> json) =>
    FavoriteResponse(
      userId: (json['userId'] as num?)?.toInt(),
      tourId: (json['tourId'] as num?)?.toInt(),
      tour:
          json['tour'] == null
              ? null
              : TripManagerResponse.fromJson(
                json['tour'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$FavoriteResponseToJson(FavoriteResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'tourId': instance.tourId,
      'tour': instance.tour,
    };
