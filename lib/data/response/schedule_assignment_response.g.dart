// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_assignment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleAssignmentResponse _$ScheduleAssignmentResponseFromJson(
  Map<String, dynamic> json,
) => ScheduleAssignmentResponse(
  id: (json['id'] as num?)?.toInt(),
  code: json['code'] as String?,
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  isAssignment: json['isAssignment'] as bool?,
);

Map<String, dynamic> _$ScheduleAssignmentResponseToJson(
  ScheduleAssignmentResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'isAssignment': instance.isAssignment,
};
