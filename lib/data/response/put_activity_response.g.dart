// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_activity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutActivityResponse _$PutActivityResponseFromJson(Map<String, dynamic> json) =>
    PutActivityResponse(
      data:
          json['data'] == null
              ? null
              : ActivityResponseData.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$PutActivityResponseToJson(
  PutActivityResponse instance,
) => <String, dynamic>{'data': instance.data};
