// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_review_requets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadReviewRequets _$ReadReviewRequetsFromJson(Map<String, dynamic> json) =>
    ReadReviewRequets(
      id: (json['id'] as num).toInt(),
      isRead: json['isRead'] as bool,
    );

Map<String, dynamic> _$ReadReviewRequetsToJson(ReadReviewRequets instance) =>
    <String, dynamic>{'id': instance.id, 'isRead': instance.isRead};
