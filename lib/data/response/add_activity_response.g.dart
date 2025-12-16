// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_activity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddActivityResponse _$AddActivityResponseFromJson(Map<String, dynamic> json) =>
    AddActivityResponse(
      data:
          json['data'] == null
              ? null
              : AddActivityResponseData.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$AddActivityResponseToJson(
  AddActivityResponse instance,
) => <String, dynamic>{'data': instance.data};

AddActivityResponseData _$AddActivityResponseDataFromJson(
  Map<String, dynamic> json,
) => AddActivityResponseData(
  id: (json['id'] as num?)?.toInt(),
  action: json['action'] as String?,
);

Map<String, dynamic> _$AddActivityResponseDataToJson(
  AddActivityResponseData instance,
) => <String, dynamic>{'id': instance.id, 'action': instance.action};
