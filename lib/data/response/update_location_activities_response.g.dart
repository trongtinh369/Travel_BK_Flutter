// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_location_activities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLocationActivitiesResponse _$UpdateLocationActivitiesResponseFromJson(
  Map<String, dynamic> json,
) => UpdateLocationActivitiesResponse(
  data:
      json['data'] == null
          ? null
          : UpdateLocationActivitiesData.fromJson(
            json['data'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$UpdateLocationActivitiesResponseToJson(
  UpdateLocationActivitiesResponse instance,
) => <String, dynamic>{'data': instance.data};

UpdateLocationActivitiesData _$UpdateLocationActivitiesDataFromJson(
  Map<String, dynamic> json,
) => UpdateLocationActivitiesData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$UpdateLocationActivitiesDataToJson(
  UpdateLocationActivitiesData instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
